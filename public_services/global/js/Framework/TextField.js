
function TextField(properties){
    this.config = {
        id:""
        ,type:""
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
        ,maxLength:0
        ,minLength:0
    };
    DaBurnerGermany.writePropertiesToObject(properties, this);
    this.smallClass = "form-control-sm";
    this.subtype = "";
    if(this.config.type == ""){
        this.fieldType = "text";
        this.subtype = "text";
    }
    else{
        this.fieldType = this.config.type; 
    }
    
}

TextField.prototype.create = function(){
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
            ,'<input '
                + (this.config.id != "" ? 'id="' + this.config.id + '"':"")
                + ' type="'+this.fieldType + '"'
                + (this.subtype != "" ? ' subtype = "'+this.subtype + '"' : "" )
                + ' class="'+this.config.cls.join(" ") + '"'
                + ' value="'+this.config.value + '"'
                + (this.config.minLength > 0 ? ' DBGMinLength="'+this.config.minLength + '"' : "")
                + (this.config.maxLength > 0 ? ' DBGMaxLength="'+this.config.maxLength + '"' : "")
                + (this.config.onKeyup !== '' ? ' onkeyup = "'+this.config.onKeyup + '"' : '')
                + (this.config.onselect !== '' ? ' onselect = "'+this.config.onselect + '"' : '')
                + (this.config.disabled == true ? " disabled" : "")
                + (this.config.readOnly == true ? " readonly" : "")
                + '>'

        ]
    }).create();
}