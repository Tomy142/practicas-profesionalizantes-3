class ApplicationModel extends EventTarget
{
    constructor()
    {
        super();
        this.objects = new Map();
    }

    addObject( id, object )
    {
        if(!this.objects.has(id)){
            this.objects.set(id, object);
            this.dispatchEvent( new CustomEvent('modelchanged') );
        }else{
            console.warn(`ID duplicado: ${id}`)
        }
    }

    getObject(id)
    {
        return this.objects.get(id);
    }

    getObjectIterator()
    {
        return this.objects.values();
    }
}