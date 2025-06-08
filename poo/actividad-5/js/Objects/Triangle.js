import { Figure } from "./Figure.js";

class TriangleModel extends Figure{
    constructor(x,y, size, color)
    {
        super(x,y, color);
        this._size = size;
    }

    draw(ctx)
    {
        const h = this._size * Math.sqrt(3) / 2;
        
        ctx.save();
        ctx.tranlate(this._x, this._y);
        ctx.rotate(this._angle);
        ctx.beginPath();
        ctx.moveTo(0, -h /2) // vertice superior
        ctx.lineTo(-this._size / 2, h /2 );// vertice izquierdo
        ctx.lineTo(this._size / 2, h /2 );//vertice derecho
        ctx.closePath();
        ctx.fillStyle= this._color;
        ctx.fill();
        ctx.restore();
    }
}

export{TriangleModel}