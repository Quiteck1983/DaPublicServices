function FormGroup(properties){

    this.config={
        id:""
        ,cls:["form-group"]
        ,items:[]
        ,width:0
        ,hidden:false
    };
    
    DaBurnerGermany.writePropertiesToObject(properties, this);
    
    this.hiddenClass = "hidden";
}

FormGroup.prototype.create = function(){

    if(this.config.width > 0){
        let _class = "col-md-"+this.config.width
        DaBurnerGermany.addClass(_class, this);
    }
    if(this.config.hidden == true){
        DaBurnerGermany.addClass(this.hiddenClass, this);
    }

    let content='<div class="'+this.config.cls.join(' ')+'">';
    
    for(var i=0;i<this.config.items.length;i++){
        content += this.config.items[i];

    }

    content += '</div>';

    //DaBurnerGermany.globalFormGroupConfig = this.config_default;

    return content;
}