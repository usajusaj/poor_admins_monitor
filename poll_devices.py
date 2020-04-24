#!/usr/bin/env python3

import logging
import sqlite3
from pathlib import Path

DEVICES_ROOT = Path('/sys/bus/w1/devices/')

log = logging.getLogger(__file__)


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
        existing_devices = dict(conn.execute("SELECT name, id FROM device;"))

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
                existing_devices[name] = cur.lastrowid

            device_id = existing_devices[name]

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
            else:
                log.warning("Device %s failed CRC", device.name)


if __name__ == '__main__':
    main()
