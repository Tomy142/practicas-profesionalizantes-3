import{ApplicationUI}from "./js/ApplicationUI.js";
function main()
{
    let model = new ApplicationModel();
    let ui = new ApplicationUI();
    let controller = new ApplicationController(ui, model);

    controller.init();

    document.body.appendChild(ui);
}

window.onload = main;