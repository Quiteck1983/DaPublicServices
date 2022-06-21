function FieldLabel(properties){
    this.config={
        id:""
        ,label:""
    };

    DaBurnerGermany.writePropertiesToObject(properties, this);
}

FieldLabel.prototype.create = function(){
    let retval = "";
    if(this.config.id !== "" && this.config.label !== ""){
        retval = '<label for="'+this.config.id+'">'+this.config.label+'</label>';
    }
    return retval;
}