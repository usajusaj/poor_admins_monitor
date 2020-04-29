# Various config files

## [pam-thermal.service](pam-thermal.service)
Systemd service file. Put this file into `/etc/systemd/system`.

To enable it at boot:
```shell script
$ sudo systemctl enable pam-thermal
```

To run the server:
```shell script
$ sudo systemctl start pam-thermal
``` 