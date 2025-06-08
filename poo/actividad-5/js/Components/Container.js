class Container extends HTMLElement
{
    constructor()
    {
        super();
        const shadow = this.attachShadow({mode: 'open'});
        const style = document.createElement('style');
        style.textContent =`
            .container{
                margin:10px;
                flex-direction: row;
                width: 1800px;
                height: 600px;
                background: linear-gradient(to left, #0ec6f0, #ff4c4c);
                border-radius: 100px;
                display: flex;
                padding: 30px;
            }
        `;

        this.containerDiv= document.createElement('div');
        this.containerDiv.className = 'container';

        shadow.appendChild(style);
        shadow.appendChild(this.containerDiv);
    }

    appendChild(child)
    {
        this.containerDiv.appendChild(child);
    }
}

customElements.define('container-wc', Container);

export{Container};