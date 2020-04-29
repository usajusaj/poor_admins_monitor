const COLOURS = [
    "#ce4d3e",
    "#64ac48",
    "#7263cc",
    "#9a963f",
    "#bc69c0",
    "#4aac8b",
    "#d04287",
    "#c88441",
    "#698ecd",
    "#c0687c"
]
let currentColour = 0; // For cycling over the list

const canvas = document.getElementById('chart');
const ctx = canvas.getContext('2d');
const devices = document.querySelectorAll(`[data-device-id]`);
let chartjs;

function removeTrack(device_id) {
    const aEle = document.querySelector(`[data-device-id="${device_id}"]`);
    aEle.classList.remove('is-active');
    aEle.style.color = "";

    let i = 0;
    for (let ds of chartjs.data.datasets) {
        if (ds['label'] === aEle.text) {
            chartjs.data.datasets.splice(i, 1);
        }
        i++;
    }

    chartjs.update();
}

function addTrack(device_id, clear) {
    const aEle = document.querySelector(`[data-device-id="${device_id}"]`);

    fetch(`/api/v1/device/get/${device_id}/history?minutes=1000`)
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            if (clear) {
                for (let dev of devices) {
                    dev.classList.remove('is-active');
                }
                chartjs.data = {datasets: []};
            }
            aEle.classList.add('is-active');

            let track = {
                label: aEle.dataset["deviceName"],
                fill: false,
                data: []
            }

            for (let timePoint of data["device"]["history"]) {
                track.data.unshift({
                    x: timePoint.ts,
                    y: timePoint.t
                });
            }

            let found = false;
            for (let ds of chartjs.data.datasets) {
                if (ds['label'] === track['label']) {
                    ds['data'] = track['data'];
                    found = true;
                }
            }

            if (!found) {
                track.pointColor = COLOURS[currentColour++ % COLOURS.length];
                track.backgroundColor = track.pointColor;
                track.borderColor = track.pointColor;
                aEle.style.color = track.pointColor;

                chartjs.data.datasets.push(track);
            }

            chartjs.options.legend.display = chartjs.width > 768;
            chartjs.update();
        });
}

// noinspection JSValidateTypes
chartjs = new Chart(ctx, {
    type: 'line',
    data: {},
    options: {
        maintainAspectRatio: false,
        onResize: (self, size) => {
            console.log(self, size);
            self.options.legend.display = size.width > 768;
            self.update();
        },
        legend: {
            // display: false
        },
        scales: {
            xAxes: [{
                type: 'time',
                time: {
                    unit: 'minute',
                    stepSize: 1
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Time'
                }
            }],
            yAxes: [{
                scaleLabel: {
                    display: true,
                    labelString: 'Temperature (°C)'
                },
                ticks: {
                    suggestedMin: 15,
                    suggestedMax: 30
                }
            }]
        },
        elements: {
            point: {
                radius: 0
            }
        }
    }
});

for (let dev of document.querySelectorAll(`[data-device-id]`)) {
    dev.addEventListener('click', evt => {
        if (evt.target.classList.contains('is-active')) {
            removeTrack(evt.target.dataset["deviceId"]);
        } else {
            addTrack(evt.target.dataset["deviceId"], false);
        }
        evt.preventDefault();
    });
}