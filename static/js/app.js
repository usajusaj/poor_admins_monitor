(() => {
    const canvas = document.getElementById('chart');
    const ctx = canvas.getContext('2d');

    let chartjs = new Chart(ctx, {
        type: 'line',
        data: {},
        options: {
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
                    }
                }]
            }
        }
    });

    for (let dev of document.querySelectorAll(`[data-device-id]`)) {
        dev.addEventListener('click', evt => {
            fetch(`/api/v1/device/get/${evt.target.dataset["deviceId"]}/history?minutes=1000`)
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    for (let dev of document.querySelectorAll(`[data-device-id]`)) {
                        dev.parentElement.classList.remove('is-active');
                    }
                    evt.target.parentElement.classList.add('is-active');

                    let chartData = {
                        datasets: [{
                            label: evt.target.text,
                            // fill: false,
                            data: []
                        }]
                    };

                    for (let timePoint of data["device"]["history"]) {
                        chartData.datasets[0].data.unshift({
                            x: timePoint.ts,
                            y: timePoint.t
                        });
                    }

                    chartjs.data = chartData;
                    canvas.classList.remove('hide');
                    chartjs.update();
                });

            evt.preventDefault();
        });
    }
})();
