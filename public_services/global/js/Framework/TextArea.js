
function TextArea(properties){
    this.config = {
        id:""
        ,type:""
        ,subtype:""
        ,cls:["form-control"]
        ,fieldLabel:""
        ,width:0
        ,height:0
        ,value:""
        ,hidden:false
        ,disabled:false
        ,readOnly:false
        ,isSmall:false
        ,allowBlank:true
        ,onselect:""
        ,onKeyup:""
        ,onchange:""
        ,data:""
        ,allowDecimals:false
        ,allowNegative:false
    };
    DaBurnerGermany.writePropertiesToObject(properties, this);
    this.smallClass = "form-control-sm";

    if(this.config.height == 0){
        this.config.height = 8;
    }
}

TextArea.prototype.create = function(){
    if(DaBurnerGermany.getSmallView() == true){
        DaBurnerGermany.addClass(this.smallClass, this)
    }
    if(this.config.allowBlank == false){
        DaBurnerGermany.setAllowBlank(this.config.allowBlank, this);
    }

    return new FormGroup({
        width:this.config.width
        ,hidden:this.config.hidden
        ,items:[
            new FieldLabel({
                id:this.config.id
                ,label:this.config.fieldLabel
            }).create()
            ,'<textarea '
                + (this.config.id != "" ? 'id="' + this.config.id + '"':"")
                + ' rows = "'+this.config.height+'"' 
                + ' class="'+this.config.cls.join(" ") + '"'
                + ' value="'+this.config.value + '"'
                + (this.config.onKeyup !== '' ? ' onkeyup = "'+this.config.onKeyup + '"' : '')
                + (this.config.onselect !== '' ? ' onselect = "'+this.config.onselect + '"' : '')
                + (this.config.disabled == true ? " disabled" : "")
                + (this.config.readOnly == true ? " readonly" : "")
                + '>'
                + '</textarea>'

        ]
    }).create();
}