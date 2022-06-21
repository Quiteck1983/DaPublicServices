function DateField(properties){
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

    let browserVersion = DaBurnerGermany.getBrowserVersions();

    this.useDateField = false;



    if(browserVersion.Edge == true){
        this.useDateField = true;
    }
    else if(browserVersion.Chrome >= 20){
        this.useDateField = true;
    }
    else if(browserVersion.Opera >= 11){
        this.useDateField = true;
    }
    else if(browserVersion.Firefox >= 57){
        this.useDateField = true;
    }

    DaBurnerGermany.writePropertiesToObject(properties, this);


    

    this.smallClass = "form-control-sm";
    this.subtype = "date";
    this.dateDefaultStr = "__.__.____";

    if(this.useDateField){
        this.fieldType = "date";
        this.config.onKeyup = this.config.onselect;
    }
    else{
        this.fieldType = "text";
        this.config.onselect = "";
        if(this.config.value == ""){
            this.config.value == this.dateDefaultStr;
        }

    }

    

}

DateField.prototype.create = function(){
    
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
                + ' subtype = "'+this.subtype + '"'
                + ' class = "'+this.config.cls.join(" ") + '"'
                + ' value = "'+this.config.value + '"'
                + (this.config.onKeyup !== '' ? ' onkeyup = "'+this.config.onKeyup + '"' : '')
                + (this.config.onselect !== '' ? ' onselect = "'+this.config.onselect + '"' : '')
                + (this.config.disabled == true ? " disabled" : "")
                + (this.config.readOnly == true ? " readonly" : "")
                + ' min="'+DaBurnerGermany.minDate+'"'
                + ' max="'+DaBurnerGermany.maxDate+'"'
                + '>'

        ]
    }).create();
}