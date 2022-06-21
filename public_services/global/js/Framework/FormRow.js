function CompositeField(properties){
    this.config = {
        items:[]
    };

    DaBurnerGermany.writePropertiesToObject(properties, this);
}

CompositeField.prototype.create = function(){
    let content='<div class="form-row">';
    
    for(var i=0;i<this.config.items.length;i++){
        content += this.config.items[i];

    }

    content += '</div>';
    return content;
}