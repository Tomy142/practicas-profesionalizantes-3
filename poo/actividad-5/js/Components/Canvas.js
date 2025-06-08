class Canvas extends HTMLElement
{
    constructor()
    {
        super();
        const shadow = this.attachShadow({mode: 'open'});

        const style = document.createElement('style');
        style.textContent = `
            canvas{
                padding: 10px;
                border: 4px solid #000;
                height: 580px;
                background-color: #eee;
            }
        `;

        const canvas = document.createElement('canvas');
        canvas.width = 800;
        canvas.height = 580;

        this.canvas = canvas;

        shadow.appendChild(style);
        shadow.appendChild(canvas);
        
    }

    getDrawingContext2D(){
        return this.canvas.getDrawingContext('2d');
    }

    clear(){
        const ctx = this.getDrawingContext2D();
        ctx.clearRect(0,0,this.canvas.width, this.canvas.height);
    }

}

customElements.define('canvas-wc', Canvas);

export{Canvas};