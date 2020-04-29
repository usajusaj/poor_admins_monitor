const devices = document.querySelectorAll(`[data-device-id]`);

function scheduleDevice(idx) {
    setTimeout(function () {
        let device = devices[idx % devices.length];
        let device_id = device.dataset['deviceId'];

        fetch(`/api/v1/device/get/${device_id}/current`)
            .then((response) => {
                return response.json();
            })
            .then((data) => {
                device.querySelector(".temperature").innerHTML = data["temperature"];
                device.querySelector(".timestamp").innerHTML = (new Date()).toLocaleTimeString();
            });

        scheduleDevice(idx + 1);
    }, 1000);
}

if (devices.length > 0) {
    scheduleDevice(0);
}
