import{Container}from".Components/Container.js";
import{Table}from".Components/Table.js";
import{Sidebar}from".Components/Side-bar.js";
import{Canvas}from".Components/Canvas.js";

class ApplicationUI extends HTMLElement 
{
    constructor() 
    {
        super();                                                // llama al constructor de HTMLElement
        const shadow = this.attachShadow({ mode: 'closed' });   // crea un shadowDOM cerrado, para encapsular

        // ==== Styles ====
        const style = document.createElement('style');
        style.textContent = `
            :host {
                background-color: rgb(45,45,45);
                align-items: center;
                justify-content: center;
                display: flex;
                height: 100vh;
                font-family: Arial, sans-serif;
            }
        `;

        this.container = new Container();
        this.sidebar = new Sidebar();
        this.canvas = new Canvas();
        this.table = new Table();

        // ==== Assemble ====
        this.container.appendChild(this.sidebar);
        this.container.appendChild(this.canvas);
        this.container.appendChild(this.table);

        this.btnRect = this.sidebar.btnRect;
        this.btnCircle = this.sidebar.btnCircle;
        this.btnTriangle = this.sidebar.btnTriangle;

        shadow.appendChild(style);
        shadow.appendChild(this.container);

        this.colorInput = this.sidebar.colorInput;
        this.tableElement = this.table;

        //-------------------------------Event management-------
        this.btnRect.onclick = () =>
        {
            //console.log('click on btnRect');
            this.dispatchEvent( new CustomEvent('createRectangleRequest') );
        }

        this.btnCircle.onclick = () =>
        {
            
            this.dispatchEvent( new CustomEvent('createCircleRequest') );
        }

        this.btnTriangle.onclick = () =>
        {
            
            this.dispatchEvent( new CustomEvent('createTriangleRequest') );
        }

    }

    connectedCallback(){
        this.ctx = this.canvas.getContext2D();
        if(!this.ctx){
            console.error('No se pudo obtener el contexto 2D');
        }
    }

    static getDispatchedEvents()
    {
        return ['createRectangleRequest', 'createCircleRequest','createTriangleRequest'];
    }

    getDrawingContext2D()
    {
        return this.canvas.getDrawingContext('2d');
    }

    getTableElement(){
        return  this.tableElement;
    }

    clearCanvas(){
        this.canvas.clear();
    }

    getFormData()
    {
        return{
            color: this.colorInput.value,
            selectedFigure: null,
        };  
    }

    render(objects) {
        this.ctx.clearRect(0, 0, this.canvas.canvas.width, this.canvas.canvas.height);
        for (const item of objects.values()) {
            item.draw(this.ctx);
        }
    }
}

customElements.define('applicationui-wc', ApplicationUI );

export{ApplicationUI};