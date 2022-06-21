function Buttons(properties){
    this.config = {
        id:""
        ,text:""
        ,width:0
        ,dataToggle:""
        ,dataTarget:""
        ,areaExpanded:""
        ,areaControls:""
        ,onclick:""
        ,cls:["btn"]
        ,disabled:false
    };

    DaBurnerGermany.writePropertiesToObject(properties, this);

    this.smallClass = ["btn-sm"];
    this.type = "button";
}

Buttons.prototype.create = function(){
    if(DaBurnerGermany.getSmallView() == true){
        for(var i = 0; i < this.smallClass.length;i++){
            DaBurnerGermany.addClass(this.smallClass[i], this);
        }
    }
    if(this.config.allowBlank == false){
        DaBurnerGermany.setAllowBlank(this.config.allowBlank, this);
    }

    let btnItem = ''
        +'<button '
        + (this.config.id != "" ? ' id="' + this.config.id + '"':"")
        + ' type="'+this.type + '"'
        + ' class="'+this.config.cls.join(" ") + '"'
        + (this.config.onclick !== '' ? ' onclick = "'+this.config.onclick + '"' : '')
        + (this.config.disabled == true ? " disabled" : "")
        + (this.config.dataToggle != "" ? ' data-toggle="'+this.config.dataToggle+'"' : "")
        + (this.config.dataTarget != "" ? ' data-target="'+this.config.dataTarget+'"' : "")
        + (this.config.areaExpanded != "" ? ' aria-expanded="'+this.config.areaExpanded+'"' : "")
        + (this.config.areaControls != "" ? ' aria-controls="'+this.config.areaControls+'"' : "")
        +'>'
        +this.config.text
        +'</button>';


    if(this.config.width == 0){
        return btnItem;
    }
    else{
        return new FormGroup({
            width:this.config.width
            ,hidden:this.config.hidden
            ,items:[
                btnItem
            ]
        }).create();
    }
}