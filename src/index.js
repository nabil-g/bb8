import { Elm } from "./elm/Main.elm";
import style from "./assets/styles/main.scss";
require("./assets/easyble");

let env = ENV;

let currentDevice = null;

let devices = [];

const DFRBLU_SERVICE_UUID = "0000dfb0-0000-1000-8000-00805f9b34fb";
const DFRBLU_CHAR_RXTX_UUID = "0000dfb1-0000-1000-8000-00805f9b34fb";
const DFRBLU_TX_UUID_DESCRIPTOR = "00002902-0000-1000-8000-00805f9b34fb";

if (env === "DEV") {
  initialize();
}

function initialize() {
  let app = Elm.Main.init({});

  app.ports.startScan.subscribe(function() {
    disconnect(null);
    evothings.easyble.reportDeviceOnce(true);
    evothings.easyble.startScan(onScanSuccess, onScanFailure);
  });

  app.ports.disconnect.subscribe(disconnect);

  app.ports.connectTo(function(address) {
    let device = devices[address];

    // Stop scanning
    evothings.easyble.stopScan();

    // Connect to our device
    console.log("Identifying service for communication");
    device.connect(onConnectSuccess, onConnectFailure);
  });

  app.ports.sendData.subscribe(function(data) {
    data = new Uint8Array(data);

    app.device.writeCharacteristic(
      app.DFRBLU_CHAR_RXTX_UUID,
      data,
      onMessageSendSuccess,
      onMessageSendFailure
    );
  });

  let onMessageSendSuccess = function() {
    console.log("Succeded to send message.");
  };

  let onMessageSendFailure = function(errorCode) {
    console.log("Failed to send data with error: " + errorCode);
    app.ports.messageSendFailure.send("Failed to send data");
  };

  let onConnectSuccess = function(device) {
    // Connect to the appropriate BLE service
    device.readServices(
      [DFRBLU_SERVICE_UUID],
      onServiceSuccess,
      onServiceFailure
    );
  };

  let onServiceSuccess = function(device) {
    // Application is now connected
    //app.connected = true;
    currentDevice = device;

    app.ports.serviceSuccess.send({
      address: device.address,
      name: device.name,
      rssi: device.rssi
    });

    console.log("Connected to " + device.name);

    device.enableNotification(DFRBLU_CHAR_RXTX_UUID, receivedData, function(
      errorCode
    ) {
      console.log("BLE enableNotification error: " + errorCode);
    });
  };

  let onServiceFailure = function(errorCode) {
    // Disconnect and show an error message to the user.
    app.ports.serviceFailure.send("Device is not from DFRobot");

    // Write debug information to console.
    console.log("Error reading services: " + errorCode);
  };

  let onConnectFailure = function(errorCode) {
    app.ports.connectFailure.send("Failed to connect to device");

    // Write debug information to console
    console.log("Error " + errorCode);
  };

  let disconnect = function(error) {
    if (error !== null) {
      alert(error);
    }
    currentDevice = null;
    devices = [];
    evothings.easyble.stopScan();
    evothings.easyble.closeConnectedDevices();

    console.log("Disconnected");
  };

  let onScanSuccess = function(device) {
    if (device.name != null) {
      devices[device.address] = device;

      app.ports.scanSuccess.send({
        address: device.address,
        name: device.name,
        rssi: device.rssi
      });

      currentDevice = device;

      console.log(
        "Found: " + device.name + ", " + device.address + ", " + device.rssi
      );
    }
  };

  let onScanFailure = function(errorCode) {
    app.ports.scanFailure.send("Failed to scan for devices.");

    // Write debug information to console.
    console.log("Error " + errorCode);
  };

  let receivedData = function(data) {
    let dataArray = new Uint8Array(data);

    if (dataArray[0] === 0xad) {
      console.log(
        "Data received: [" +
          dataArray[0] +
          ", " +
          dataArray[1] +
          ", " +
          dataArray[2] +
          "]"
      );

      var value = (dataArray[2] << 8) | dataArray[1];

      console.log(value);

      app.ports.receivedData.send(value);
    }
  };
}
