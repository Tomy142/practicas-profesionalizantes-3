import { Figure } from "./Figure.js";

class RectangleModel extends Figure
{
    constructor(x, y, width, height, color) 
    {
        super(x, y, color)

        this._width = width;
        this._height = height;

    }

    draw(ctx) 
    {
        ctx.save();
        ctx.translate(this._x, this._y);
        ctx.rotate(this._angle);
        ctx.fillStyle = this._color;
        ctx.fillRect(-this._width / 2, -this._height / 2, this._width, this._height);
        ctx.restore();
    }
}

export{RectangleModel};