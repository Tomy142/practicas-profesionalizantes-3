import { RectangleModel } from "./Objects/Rectangle.js";
import { CircleModel } from "./Objects/Circle.js";

class Controller {
        constructor(rectangle) {
            this.rectangle = rectangle;
            this._KEY_CODE = {
                LEFT: 37,
                UP: 38,
                RIGHT: 39,
                DOWN: 40
            };

            document.addEventListener('keydown', this.keyDownHandler.bind(this));
        }

        keyDownHandler(event) {
            switch (event.keyCode) {
                case this._KEY_CODE.UP:
                    this.rectangle.moveForward();
                    break;
                case this._KEY_CODE.DOWN:
                    this.rectangle.moveBackward();
                    break;
                case this._KEY_CODE.LEFT:
                    this.rectangle.rotateLeft();
                    break;
                case this._KEY_CODE.RIGHT:
                    this.rectangle.rotateRight();
                    break;
            }
        }
}

export{Controller};