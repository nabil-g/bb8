import { Elm }  from './elm/Main.elm';
import style from './assets/styles/main.scss';
require("./assets/easyble");

let env = ENV;


if (env === "DEV") {
    initialize();
}

function initialize () {
    let app = Elm.Main.init({});

   // app.ports.disconnect.subscribe(function (x) {
        //console.log("");
    //});

}
