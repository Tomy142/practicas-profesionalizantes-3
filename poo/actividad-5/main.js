import { GameEngineRenderer } from "./js/Renderer.js";
import { Controller } from "./js/Controller.js";
function main() {
    var canvas = document.createElement('canvas');
    canvas.width = 1910;
    canvas.height = 905;
    document.body.appendChild(canvas);

    var rectangle= new Rectangle(250, 250, 150, 125);
    var renderer = new GameEngineRenderer(canvas);
    var controller = new RectangleController(auto);
    setInterval(function () {
            renderer.render();
        }, 16); 
}

window.onload = main;