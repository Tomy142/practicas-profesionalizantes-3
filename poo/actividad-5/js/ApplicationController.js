import { RectangleModel } from "./Objects/Rectangle.js";
import { CircleModel } from "./Objects/Circle.js";
import { TriangleModel } from "./Objects/Triangle.js";

class ApplicationController
{
    constructor( view, model )
    {
        this.view = view;
        this.model = model;
        this.ctx = this.view.getDrawingContext2D();
        this.selectedFigureId = null;
        this._KEY_CODE = {
            W: 87,
            A: 65,
            S: 83,
            D: 68
        }
    }

    init()
    {
        this.model.addEventListener('modelchanged', this.onModelChanged.bind(this) );
        this.view.addEventListener('createRectangleRequest', this.onCreateRectangleButtonClick.bind(this) );
        this.view.addEventListener('createCircleRequest', this.onCreateCircleButtonClick.bind(this) );
        this.view.addEventListener('createTriangleRequest', this.onCreateTriangleButtonClick.bind(this) );
        this.view.addEventListener('figureSelectionChanged', this.onFigureSelectionChanged.bind(this) );

        window.addEventListener('keydown', this.onKeyDown.bind(this));
    }

    release()
    {
        //this.view.removeEventListener()
    }

    //Estrategia 1: Procesar eventos de notificación del modelo
    onModelChanged(event)
    {
        this.view.clearCanvas();

        //Drawing
        for( let object of this.model.getObjectIterator() )
        {
            object.draw( this.ctx );
        }
    }

    onFigureSelectionChanged(event){
        this.selectedFigureId = event.detail.id;
    }

    //Manejadores de eventos producidos desde la UI
    onCreateRectangleButtonClick(event)
    {
        //Datos pedidos al usuario
        let id = parseInt(prompt('Ingrese ID:'));
        let width = parseInt(prompt('Ingrese ancho:'));
        let height = parseInt(prompt('Ingrese alto:'));
        let x = parseInt(prompt('Ingrese x:'));
        let y = parseInt(prompt('Ingrese y:'));

        //Datos pedidos a la interfaz
        let color = this.view.getFormData().color;

        //Acceso al modelo
        let new_figure = new RectangleModel(x,y,width,height,color)
        this.model.addObject(id, new_figure);

        this.view.getTableElement().addRow(id,'Rectangulo');
    }

    onCreateCircleButtonClick(event)
    {
        //Datos pedidos al usuario
        let id = parseInt(prompt('Ingrese ID:'));
        let radius = parseInt(prompt('Ingrese radio:'));
        let x = parseInt(prompt('Ingrese x:'));
        let y = parseInt(prompt('Ingrese y:'));

        //Datos pedidos a la interfaz
        let color = this.view.getFormData().color;

        //Acceso al modelo
        let new_figure = new CircleModel(x,y,radius,color)
        this.model.addObject(id, new_figure);

        this.view.getTableElement().addRow(id,'Circulo');

    }

    onCreateTriangleButtonClick(event)
    {
        //Datos pedidos al usuario
        let id = parseInt(prompt('Ingrese ID:'));
        let size = parseInt(prompt('Ingrese el tamaño del lado:'));
        let x = parseInt(prompt('Ingrese x:'));
        let y = parseInt(prompt('Ingrese y:'));

        //Datos pedidos a la interfaz
        let color = this.view.getFormData().color;

        //Acceso al modelo
        let new_figure = new TriangleModel(x,y,size,color)
        this.model.addObject(id, new_figure);

        this.view.getTableElement().addRow(id,'Triangulo');
    }

    //Manejo de figura
    onKeyDown(event){
        if(!this.selectedFigureId) return;

        const figure = this.model.getObject(parseInt(this.selectedFigureId));
        if(!figure)return;
        

        switch(event.keyCode){
            case this._KEY_CODE.W:
                figure.move(10);
                break;
            case this._KEY_CODE.S:
                figure.move(-10);
                break;
            case this._KEY_CODE.A:
                figure.rotate(-0.1);
                break;
            case this._KEY_CODE.D:
                figure.rotate(0.1);
                break;
        }
        this.model.dispatchEvent(new Event('modelchanged'));
    }
}

export{ApplicationController};