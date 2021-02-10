#!/usr/bin/env python3
import configparser
import logging
import smtplib
import sqlite3
from email.message import EmailMessage
from pathlib import Path

DEVICES_ROOT = Path('/sys/bus/w1/devices/')

log = logging.getLogger(__file__)

config = configparser.ConfigParser()
config.read([Path(__file__).parent / 'conf/pam_poll.ini', '/etc/pam_poll.ini'])


def create_msg(subject, txt=None, html=None):
    """ Prepare an email message

    :param str subject: Email subject
    :param str txt: Email text contents
    :param str html: Email html contents
    :return: Formatted Message ready for sending
    :rtype: EmailMessage
    """
    msg = EmailMessage()
    msg['Subject'] = subject

    if txt:
        msg.set_content(txt)

    if html:
        msg.add_alternative(html, subtype='html')

    return msg


def send_email(msg):
    """ Send email to recepients defined in config file, if any

    :param EmailMessage msg: Message we want to send
    """
    if not config.has_section('EMAIL'):
        return

    if not config.getboolean('EMAIL', 'enabled', fallback=False):
        return

    msg['From'] = config.get('EMAIL', 'username')
    msg['To'] = config.get('EMAIL', 'recipients').split(',')

    log.debug("Sending alert email to %s", msg['To'])

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.ehlo()
    server.starttls()
    server.login(config.get('EMAIL', 'username'), config.get('EMAIL', 'password'))
    server.send_message(msg)
    server.close()


def check_thresholds(device_name, pre_value, cur_value):
    """ Check the thresholds of this sensor and

    :param str device_name: Name of current device
    :param int pre_value: Previous value
    :param int cur_value: Current value
    :return: Message for alert or None if there is no problem
    :rtype: str | None
    """
    if not config.has_section('THRESHOLDS'):
        return

    if pre_value is None:
        return

    # our settings are stored in normal format
    low = config.getfloat('THRESHOLDS', 'temp_low') * 1000
    high = config.getfloat('THRESHOLDS', 'temp_high') * 1000

    if cur_value <= low < pre_value:
        # We got too cold
        return "Sensor '%s' is too cold: %.3fC" % (device_name, cur_value / 1000.)
    elif pre_value <= low < cur_value:
        # We recovered from cold
        return "Sensor '%s' recovered: %.3fC" % (device_name, cur_value / 1000.)
    elif pre_value < high <= cur_value:
        # We got too hot
        return "Sensor '%s' is too hot: %.3fC" % (device_name, cur_value / 1000.)
    elif cur_value < high <= pre_value:
        # We recovered from hot
        return "Sensor '%s' recovered: %.3fC" % (device_name, cur_value / 1000.)


def main():
    import argparse

    parser = argparse.ArgumentParser(description='Poll 1Wire devices')
    # noinspection PyTypeChecker
    parser.add_argument('sqlite3_db', type=Path, help='Path to sqlite3 database')
    # noinspection PyTypeChecker
    parser.add_argument('-d', '--devices_root', type=Path, default=DEVICES_ROOT, help='Path to 1wire devices')
    parser.add_argument("-v", "--verbose", dest="verbose_count",
                        action="count", default=0,
                        help="increases log verbosity for each occurrence.")

    args = parser.parse_args()

    logging.basicConfig(level=logging.WARN, format='[%(asctime)-15s] %(levelname)s %(message)s')
    log.setLevel(max(3 - args.verbose_count, 1) * 10)

    log.info("Connecting to DB: %s", args.sqlite3_db)
    with sqlite3.connect(args.sqlite3_db, isolation_level=None) as conn:
        conn.execute('PRAGMA journal_mode=WAL;')  # So we don't block reading the tables

        log.debug("Fetching known devices")
        existing_devices = {}
        for n, i, t, v in conn.execute("SELECT name, id, last_reading, verbose_name FROM device;"):
            existing_devices[n] = (i, t, v or n)
        log.debug("Known devices: %s", ', '.join(existing_devices.keys()))

        alerts = []

        if args.devices_root.exists():
            for device in args.devices_root.iterdir():
                log.debug("Considering device %s", device.name)

                if device.name.startswith('w1_bus'):
                    log.debug("Device %s discarded, master bus", device.name)
                    continue

                if not (device / 'name').exists() or not (device / 'w1_slave').exists():
                    log.warning("Device %s discarded, missing required files: name, w1_slave", device.name)
                    continue

                name = (device / 'name').read_text().strip()

                if name not in existing_devices:
                    log.info("Found new device %s, inserting to database", device.name)
                    cur = conn.execute("INSERT INTO device(name, path) VALUES (?, ?);", (name, str(device)))
                    existing_devices[name] = cur.lastrowid, None, name

                device_id, last_reading, verbose_name = existing_devices[name]

                log.debug("Reading temperature from device %s", device.name)
                data = (device / 'w1_slave').read_text().strip()
                lines = data.splitlines()

                if len(lines) != 2:
                    log.warning("Device %s has malformed data", device.name)
                    continue

                if lines[0].endswith('YES'):  # CRC CHECKED
                    temperature = int(lines[1].split('=')[-1])
                    log.info("Read temperature %.3fC from device %s", temperature / 1000., device.name)
                    conn.execute("UPDATE device SET last_ts=CURRENT_TIMESTAMP, last_reading=? WHERE id=?;",
                                 (temperature, device_id))

                    alert = check_thresholds(verbose_name, last_reading, temperature)
                    if alert:
                        log.warning("Threhold breach on device %s", device.name)
                        alerts.append(alert)
                else:
                    log.warning("Device %s failed CRC", device.name)
        else:
            log.warning("1-Wire folder (%s) does not exist", args.devices_root)

        if alerts:
            send_email(create_msg("PAM: Temperature threshold alert triggered!", '\n'.join(alerts)))


if __name__ == '__main__':
    main()
