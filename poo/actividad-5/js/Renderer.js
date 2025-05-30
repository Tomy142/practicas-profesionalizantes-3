import { RectangleModel } from "./Objects/Rectangle.js";
import { CircleModel } from "./Objects/Circle.js";

class GameEngineRenderer {
    constructor(canvasInstance) {
        this.canvas = canvasInstance;
        this.ctx = this.canvas.getContext('2d');
        this.objects = new Map();
    }

    addObject(id, object) {
        this.objects.set(id, object);
    }

    render() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        for (const item of this.objects.values()) {
            item.draw(this.ctx);
        }
    }
}

export{GameEngineRenderer};