import { RectangleModel } from "./Objects/Rectangle.js";
import { CircleModel } from "./Objects/Circle.js";

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

            .container {
            margin: 10px;
            flex-direction: row;
            width: 1800px;
            height: 600px;
            background: linear-gradient(to left,#0ec6f0 ,#ff4c4c);
            border-radius: 100px;
            display: flex;
            padding: 30px;
            }

            .sidebar {
            width: 600px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            top: 100%;
            bottom: 100%;
            padding: 5px;
            }

            .sidebar button {
            padding: 10px;
            font-size: 14px;
            cursor: pointer;
            }

            .sidebar input[type="color"] {
            width: 100%;
            height: 40px;
            border: none;
            cursor: pointer;
            }

            canvas {
            padding: 10px;
            border: 4px solid #000;
            height: 580px;
            background-color: #eee;
            }

            .table-panel {
            margin-left: 5px;
            width: 300px;
            padding: 5px;
            box-sizing: border-box;
            }

            table {
            width: 100%;
            border-collapse: collapse;
            background-color: #979797;
            }

            th, td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: left;
            background-color: #979797;
            }

            th {
            background-color:#979797;
            }

            td input[type="radio"] {
            display: block;
            margin: auto;
            }
        `;

        // ==== Container ====
        const container = document.createElement('div');
        container.className = 'container';
        container.style.display = 'flex';
        
        const canvas = document.createElement('div');
        canvas.className= 'canvas';

        // ==== Sidebar ====
        const sidebar = document.createElement('div');
        sidebar.className = 'sidebar';

        this.btnRect = document.createElement('button');
        this.btnRect.textContent = 'Crear rectángulo';

        this.btnCircle = document.createElement('button');
        this.btnCircle.textContent = 'Crear círculo';

        this.btnTriangle = document.createElement('button');
        this.btnTriangle.textContent = 'Crear triángulo';

        const colorLabel = document.createElement('label');
        colorLabel.setAttribute('for', 'colorPicker');
        colorLabel.textContent = 'Color:';

        this.colorInput = document.createElement('input');
        this.colorInput.type = 'color';
        this.colorInput.id = 'colorPicker';
        this.colorInput.name = 'colorPicker';

        sidebar.appendChild(this.btnRect);
        sidebar.appendChild(this.btnCircle);
        sidebar.appendChild(this.btnTriangle);
        sidebar.appendChild(colorLabel);
        sidebar.appendChild(this.colorInput);

        

        this.canvas = document.createElement('canvas');
        canvas.appendChild(this.canvas);

        // ==== Table Panel ====
        const tablePanel = document.createElement('div');
        tablePanel.className = 'table-panel';

        this.table = document.createElement('table');
        const thead = document.createElement('thead');
        const trHead = document.createElement('tr');

        const thId = document.createElement('th');
        thId.textContent = 'ID';
        const thName = document.createElement('th');
        thName.textContent = 'Nombre';
        const thSelect = document.createElement('th');
        thSelect.textContent = 'Seleccionar';

        trHead.appendChild(thId);
        trHead.appendChild(thName);
        trHead.appendChild(thSelect);
        thead.appendChild(trHead);
        this.table.appendChild(thead);

        const tbody = document.createElement('tbody');

        // Ejemplo de fila
        const exampleRow = document.createElement('tr');
        const tdId = document.createElement('td');
        tdId.textContent = '1';

        const tdName = document.createElement('td');
        tdName.textContent = 'Rectángulo';

        const tdRadio = document.createElement('td');
        const radio = document.createElement('input');
        radio.type = 'radio';
        radio.name = 'figuraSeleccionada';
        tdRadio.appendChild(radio);

        exampleRow.appendChild(tdId);
        exampleRow.appendChild(tdName);
        exampleRow.appendChild(tdRadio);
        tbody.appendChild(exampleRow);

        this.table.appendChild(tbody);
        tablePanel.appendChild(this.table);

        // ==== Assemble ====
        container.appendChild(sidebar);
        container.appendChild(canvas);
        container.appendChild(tablePanel);

        shadow.appendChild(style);
        shadow.appendChild(container);

        //-------------------------------Event management-------
        this.btnRect.onclick = () =>
        {
            //console.log('click on btnRect');
            this.dispatchEvent( new CustomEvent('createRectangleRequest') );
        }
    }

    static getDispatchedEvents()
    {
        return ['createRectangleRequest'];
    }

    getDrawingContext2D()
    {
        return this.canvas.getContext("2d");
    }

    getFormData()
    {
        let dataObject =
        {
            color: this.colorInput.value,
            selectedFigure: null
        };

        return dataObject;
    }

    render(objects) {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        for (const item of objects.values()) {
            item.draw(this.ctx);
        }
    }
}

customElements.define('applicationui-wc', ApplicationUI );



export{ApplicationUI};