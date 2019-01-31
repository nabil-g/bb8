import { Elm }  from './elm/Main.elm';
import style from './assets/styles/main.scss';
require("./assets/easyble");

let env = ENV;

let currentDevice = null;

const DFRBLU_SERVICE_UUID = '0000dfb0-0000-1000-8000-00805f9b34fb';
const DFRBLU_CHAR_RXTX_UUID = '0000dfb1-0000-1000-8000-00805f9b34fb';
const DFRBLU_TX_UUID_DESCRIPTOR = '00002902-0000-1000-8000-00805f9b34fb';

if (env === "DEV") {
    initialize();
}

function initialize () {
    let app = Elm.Main.init({});

    app.ports.startScan.subscribe(function () {
        disconnect(null);
        evothings.easyble.reportDeviceOnce(true);
        evothings.easyble.startScan(onScanSuccess, onScanFailure);

    });

    app.ports.disconnect.subscribe(disconnect);

    let disconnect = function (error) {
        if (error !== null){
            alert(error);
        }
        currentDevice = null;
        evothings.easyble.stopScan();
        evothings.easyble.closeConnectedDevices();

        console.log("Disconnected");
    };



    let onScanSuccess = function(device) {

        if(device.name != null) {

            app.ports.scanSuccess.send({
                address: device.address,
                name: device.name,
                rssi: device.rssi
            });

            currentDevice = device;

            console.log('Found: ' + device.name + ', ' + device.address + ', ' + device.rssi);


        }
    };

    let onScanFailure = function(errorCode) {

        app.ports.scanFailure.send();

        // Write debug information to console.
        console.log('Error ' + errorCode);
    };

    



}
