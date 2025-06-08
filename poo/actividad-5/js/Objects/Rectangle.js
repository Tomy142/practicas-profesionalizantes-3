import { Figure } from "./Figure.js";

class RectangleModel extends Figure
{
    constructor(x,y,w,h,color)
    {
        super(x,y,color);
        this._width = w;
        this._height = h;
        this._angle = 0;
        this._color = color;
    }

    draw(ctx)
    {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this._angle);
        ctx.fillStyle = this._color;
        ctx.fillRect(-this.width / 2, -this.height / 2, this.width, this.height);
        ctx.restore();
    }
}
export{RectangleModel};