class Sidebar extends HTMLElement
{
    constructor()
    {
        super();
        const shadow = this.attachShadow({mode: 'open'});
        const style = document.createElement('style');
        style.textContent = `
            .sidebar{
                width: 600px;
                box-sizing: border-box;
                display: flex;
                flex-direction: column;
                top: 100%;
                bottom: 100%;
                padding: 5px;
            }

            .sidebar button{
                padding: 10px;
                font-size: 14px;
                cursor: pointer;
            }
            
            .sidebar input[type="color"]{
                width: 100%;
                height: 40px;
                border: none;
                cursor: pointer;
            }
        `;
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
        colorLabel.textContent = 'Color';

        this.colorInput = document.createElement('input');
        this.colorInput.type = 'color';
        this.colorInput.id = 'colorPicker';
        this.colorInput.name = 'colorPicker';

        this.btnRect.addEventListener('click',()=>{
            this.dispatchEvent(new CustomEvent('createRectangleRequest',{bubbles: true}));
        });

        this.btnCircle.addEventListener('click',()=>{
            this.dispatchEvent(new CustomEvent('createCircleRequest',{bubbles: true}));
        });

        this.btnTriangle.addEventListener('click',()=>{
            this.dispatchEvent(new CustomEvent('createTriangleRequest',{bubbles: true}));
        });

        sidebar.appendChild(this.btnRect);
        sidebar.appendChild(this.btnCircle);
        sidebar.appendChild(this.btnTriangle);
        sidebar.appendChild(colorLabel);
        sidebar.appendChild(this.colorInput);
        shadow.appendChild(style);
        shadow.appendChild(sidebar);
    }

    getFromData()
    {return{
            color: this.colorInput.value
        };
    }
}

customElements.define('sidebar-wc', Sidebar);

export{Sidebar};