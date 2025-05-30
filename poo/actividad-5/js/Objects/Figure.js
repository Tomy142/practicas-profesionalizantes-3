class Figure
{
    constructor(x, y, color, angle = 0) 
    {
        this._x = x;
        this._y = y;
        this._color = color;
        this._angle = angle;
    }

    rotate(radians) 
    {
        this._angle += radians;
    }

    move(distance)
    {
        this._x += distance * Math.cos(this._angle);
        this._y += distance * Math.sin(this._angle);
    }
}
export{Figure};