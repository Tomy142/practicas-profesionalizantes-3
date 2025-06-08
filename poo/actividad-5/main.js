import{ApplicationUI}from "./js/ApplicationUI.js";
function main()
{
    let model = new ApplicationModel();
    let ui = document.createElement('applicationui-wc');
    let controller = new ApplicationController(ui, model);

    controller.init();

    document.body.appendChild(ui);
}

window.onload = main;