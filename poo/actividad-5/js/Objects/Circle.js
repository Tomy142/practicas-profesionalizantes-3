import { Figure } from "./Figure.js";

class CircleModel extends Figure
{
    constructor(x, y, radius, color) 
    {
        super(x, y, color)

        this._radius = radius;
    }

    draw(ctx) 
    {
        ctx.save();
        ctx.translate(this._x, this._y);
        ctx.beginPath();
        ctx.arc(0, 0, this._radius, 0, 2 * Math.PI);
        ctx.fillStyle = this._color;
        ctx.fill();
        ctx.restore();
    }
}

export{CircleModel};