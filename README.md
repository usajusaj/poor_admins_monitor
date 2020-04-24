# Poor Admin's Monitor
For my fellow sysadmins who would like to be responsible and monitor server room temperature but professional monitor appliances are too expensive.

The plan here is pretty simple, all you need is:
- Some sort of x86/ARM capable single-board computer like [RaspberryPI](https://www.raspberrypi.org/) with GPIO pins
- A few components, the star of the show is 1-Wire temperature sensor like [MAX31820](https://datasheets.maximintegrated.com/en/ds/MAX31820.pdf)
- Basic soldering experience

## Design
1-Wire ambient temperature sensing devices are cheap (~$1CAD/each), easy to control (1-wire protocol drivers are readily available) and one can chain a lot of them on a single wire. I'm using UTP since every server room has plenty spare.

I'm chose a standalone C++ web framework to avoid running the bloat that are NGINX/Apache2 + Django/PHP/... on an rpi. But deep down I just wanted to try something new.

## Building
- Download/clone Drogon: https://github.com/an-tao/drogon
- Follow its installation steps, before running cmake add this line to drogon's CMakeList.txt to fix linking errors on RaspberryPI
```cmake
target_link_libraries(${PROJECT_NAME} PUBLIC atomic)
```
- Install drogon
- Download/clone this code, do usual
```shell script
$ mkdir build
$ cd build
$ cmake ..
$ make
```

## Running
- initialize database
```shell script
sqlite3 database.db
> .read sqlite3.sql
```
- put [poll_devices.py](poll_devices.py) in a crontab at arbitrary interval, ie every minute:
```shell script
* * * * *       /home/pi/poor_admins_monitor/poll_devices.py /home/pi/poor_admins_monitor/database.db
``` 

- while database is filling up with first data, rename [config.json.template](config.json.template) to config.json and adjust settings to your liking
- run web server with
```shell script
./poor_admins_monitor
``` 

- Point browser to:
  - `http://host:port/api/v1/device/list`
  - `http://host:port/api/v1/device/get/1`
  - `http://host:port/api/v1/device/get/1/history`
  
## Future features
too many to list, but mainly a nice html UI