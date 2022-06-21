DaBurnerGermany = {
    version : '1.0',
};

/**
 * Copies all the properties of config to obj.
 * @param {Object} obj The receiver of the properties
 * @param {Object} config The source of the properties
 * @param {Object} defaults A different object that will also be applied for default values
 * @return {Object} returns obj
 * @member DaBurnerGermany apply
 */
 DaBurnerGermany.apply = function(o, c, defaults){
    // no "this" reference for friendly out of scope calls
    if(defaults){
        DaBurnerGermany.apply(o, defaults);
    }
    if(o && c && typeof c == 'object'){
        for(var p in c){
            o[p] = c[p];
        }
    }
    return o;
};


(function(){


    // Create the abstract Base class to provide an empty constructor and callParent implementations
    function Base () {
        
    }

    DaBurnerGermany.apply(Base, {
        $isClass: true,

        callParent: function (args) {
            var method;

            // This code is intentionally inlined for the least number of debugger stepping
            return (method = this.callParent.caller) && (method.$previous ||
                ((method = method.$owner ? method : method.caller) &&
                        method.$owner.superclass.self[method.$name])).apply(this, args || noArgs);
        }
    });

    Base.prototype = {
        constructor: function() {
        },
        callParent: function(args) {
            // NOTE: this code is deliberately as few expressions (and no function calls)
            // as possible so that a debugger can skip over this noise with the minimum number
            // of steps. Basically, just hit Step Into until you are where you really wanted
            // to be.
            var method,
                superMethod = (method = this.callParent.caller) && (method.$previous ||
                        ((method = method.$owner ? method : method.caller) &&
                                method.$owner.superclass[method.$name]));

            return superMethod.apply(this, args || noArgs);
        }
    };


    DaBurnerGermany.apply(DaBurnerGermany, {

        classAllowBlank : "needs-validation",
        currentObjectIteration : 0,
        elementsToCreate:[],

        minDate:'1000-01-01',
        maxDate:'9999-12-31',
        useSmallView:0,
        pageType:"custom",

        setPageType : function(type){
            this.pageType = type;
        },
        getPageType : function(type){
            return this.pageType;
        },

        urlEncode : function(o, pre){
            var empty,
                buf = [],
                e = encodeURIComponent;

            DaBurnerGermany.iterate(o, function(key, item){
                empty = DaBurnerGermany.isEmpty(item);
                DaBurnerGermany.each(empty ? key : item, function(val){
                    buf.push('&', e(key), '=', (!DaBurnerGermany.isEmpty(val) && (val != key || !empty)) ? (DaBurnerGermany.isDate(val) ? DaBurnerGermany.encode(val).replace(/"/g, '') : e(val)) : '');
                });
            });
            if(!pre){
                buf.shift();
                pre = '';
            }
            return pre + buf.join('');
        },

        urlDecode : function(string, overwrite){
            if(DaBurnerGermany.isEmpty(string)){
                return {};
            }
            var obj = {},
                pairs = string.split('&'),
                d = decodeURIComponent,
                name,
                value;
            DaBurnerGermany.each(pairs, function(pair) {
                pair = pair.split('=');
                name = d(pair[0]);
                value = d(pair[1]);
                obj[name] = overwrite || !obj[name] ? value :
                            [].concat(obj[name]).concat(value);
            });
            return obj;
        },
        urlAppend : function(url, s){
            if(!DaBurnerGermany.isEmpty(s)){
                return url + (url.indexOf('?') === -1 ? '?' : '&') + s;
            }
            return url;
        },
        each : function(array, fn, scope){
            if(DaBurnerGermany.isEmpty(array, true)){
                return;
            }
            if(!DaBurnerGermany.isIterable(array) || DaBurnerGermany.isPrimitive(array)){
                array = [array];
            }
            for(var i = 0, len = array.length; i < len; i++){
                if(fn.call(scope || array[i], array[i], i, array) === false){
                    return i;
                };
            }
        },


        getBody : function(){
            return $("#id_content");
        },
        setBody : function(content){
            let element = this.getBody();
            if(element){
                element.html(content);
            }
        },
        AddToBody : function(content){
            let element = this.getBody();
            if(element){
                element.append(content);
            }
        },
        AddToBodyTop : function(content){
            let element = this.getBody();
            if(element){
                element.prepend(content);
            }
        },

        getTitle : function() {
            return $("#pagertitle");
        },
        getTitleString : function() {
            let retval = "";
            let element = this.getTitle();
            if(element){
                retval = element[0].innerHTML; 
            }
            return retval;
        },
        setTitle : function(content) {
            let element = this.getTitle();
            if(element){
                element.html(content);
            }
        },
        AddToTitle : function(content) {
            let element = this.getTitle();
            if(element){
                element.append(content);
            }
        },

        isEmpty : function(value2test, allowBlank, replaceEmptyChar){
            if(replaceEmptyChar){
                value2test=value2test.replace(/ /g,"");
            }
            return value2test === null || value2test === undefined || ((DaBurnerGermany.isArray(value2test) && !value2test.length)) || (!allowBlank ? value2test === '' : false);
        },
        isArray : function(value2test){
            return toString.apply(value2test) === '[object Array]';
        },
        isDate : function(value2test){
            return toString.apply(value2test) === '[object Date]';
        },
        isObject : function(value2test){
            return !!value2test && Object.prototype.toString.call(value2test) === '[object Object]';
        },
        isFunction : function(v){
            return toString.apply(v) === '[object Function]';
        },

        isNumber : function(value2test){
            return typeof value2test === 'number' && isFinite(value2test);
        },
        isString : function(value2test){
            return typeof value2test === 'string';
        },
        isBoolean : function(value2test){
            return typeof value2test === 'boolean';
        },
        isElement : function(value2test) {
            return v ? !!value2test.tagName : false;
        },
        isDefined : function(value2test){
            return typeof value2test !== 'undefined';
        },

        getComponent:function(objectid){
            return $("#"+objectid);
        },
        generateID:function(){
            let id =  "dbg-comp-"+this.currentObjectIteration
            this.currentObjectIteration++;

            return id;
        },

        Button : function(properties){
            return new Buttons(properties).create();
        },
        CompositeField : function(properties){
            return new CompositeField(properties).create();
        },
        FieldSet : function(properties){
            return new FieldSet(properties).create();
        },
        TextField : function(properties){
            return new TextField(properties).create();
        },
        PortalRow : function(properties){
            return new PortalRow(properties).create();
        },
        Grid : function(properties){
            return new Grid(properties).create();
        },
        TextArea : function(properties){
            return new TextArea(properties).create();
        },
        NumberField : function(properties){
            return new NumberField(properties).create();
        },
        DateField : function(properties){
            return new DateField(properties).create();
        },
        ComboBox : function(properties){
            return new DropDown(properties).create();
        },

        setAllowBlank:function(allowBlank, obj){
            if(allowBlank == false){
                this.addClass(this.classAllowBlank,obj);
                
            }
            else{
                this.removeClass(this.classAllowBlank,obj);
            }
        },

        setAllowEmpty:function(allowBlank, objid){
            if(allowBlank == false){
                this.doAddClass(objid,this.classAllowBlank);
                
            }
            else{
                this.deleteClass(objid,this.classAllowBlank);
                this.deleteClass(objid,"form-invalid");
            }
        },


        hasClass:function(input, obj){
            let retval = false;
            for(var i=0;i<obj.config.cls.length;i++){
                if(!retval){
                    if(input == obj.config.cls[i]){
                        retval = true;
                    }
                }   
            }
            return retval;
        },

        addClass:function(input, obj){
            if(input != ""){
                if(!this.hasClass(input, obj)){
                    obj.config.cls.push(input);
                }
            }
        },

        setSmallView:function(input){
            if(input != ""){
                this.useSmallView = (input == true ? true : false);
            }
        },
        getSmallView:function(input){
            return (this.useSmallView ==  true ? true : false);
        },

        removeClass:function(input, obj){
            for(var i=0;i<obj.config.cls.length;i++){
                if(obj.config.cls[i]){
                    if(obj.config.cls[i] == input){
                        obj.config.cls.splice(i,1);
                        i--;
                    }
                }  
            }
        },



        /*check browser versions */
        getChromeVersion:function() {     
            var raw = navigator.userAgent.match(/Chrom(e|ium)\/([0-9]+)\./);
            return raw ? parseInt(raw[2], 10) : false;
        },
        getFireFoxVersion:function(){
            var match = window.navigator.userAgent.match(/Firefox\/([0-9]+)\./);
            return match ? parseInt(match[1]) : false;
        },
        getOperaVersion:function(){
            var match = window.navigator.userAgent.match(/OPR\/([0-9]+)\./);
            if(!match){
                match = window.navigator.userAgent.match(/Opera\/([0-9]+)\./);
            }
            return match ? parseInt(match[1]) : false;
        },
        getSafariVersion:function(){
            var match = window.navigator.userAgent.match(/Safari\/([0-9]+)\./);
            return match ? parseInt(match[1]) : false;
        },
        isMSEdgeBrowser:function() {     
            return navigator.userAgent.indexOf('Edge') > -1 || navigator.userAgent.indexOf('Edg') > -1 
        },

        getBrowserVersions:function() {     
            return {
                "Chrome": this.getChromeVersion()
                ,"Edge": this.isMSEdgeBrowser()
                ,"Opera": this.getOperaVersion()
                //,"Safari": this.getSafariVersion()
                ,"Firefox": this.getFireFoxVersion()
            };  
        },

        writePropertiesToObject:function(properties, obj){
            for (let el in properties) {
                if(el.toString() == "cls"){
                    if(typeof properties[el] === "object"){
                        
                        for(var i=0; i < properties[el].length; i++){
                            DaBurnerGermany.addClass(properties[el][i], obj);
                        }
                    }
                    else{
                        DaBurnerGermany.addClass(properties[el], obj);
                    }
                }
                else{
                    if(obj.config[el] !== undefined){
                        obj.config[el] = properties[el];
                    }
                }
            }
            if(obj.config.id == ""){
                obj.config.id = DaBurnerGermany.generateID();
            }
        },

        getObj:function(id){

            let object = $("#"+id); 
            if(!this.objIsDefined(object)){
                object=undefined;
            }
            return object;
        },

        objIsDefined:function(object){
            return object.length > 0;
        },

        update:function(objectid, html){
            if(this.getObj(objectid)){
                this.getObj(objectid).html(html)
            }
            else{
                console.log("IMPORTANT " + objectid + " is undefined");
            }
        },

        setDisabled:function(objectid, disabled){
            if(this.getObj(objectid)){


                this.getObj(objectid).prop("disabled",disabled);
            }
            else{
                console.log("IMPORTANT " + objectid + " is undefined");
            }
        },

        setVisible:function(objectid, visible){
            if(this.getObj(objectid)){
                if(visible == true){
                    this.getObj(objectid).show();
                }
                else{
                    this.getObj(objectid).hide();
                }
            }
            else{
                console.log("IMPORTANT object " + objectid + " is undefined");
            }
        },

        
        deleteClass:function(objectid, classname){

            if(this.getObj(objectid)){
                if(this.getObj(objectid).hasClass(classname)){
                    this.getObj(objectid).removeClass(classname);
                }
            }
            else{
                console.log("IMPORTANT " + objectid + " is undefined");
            }
        },
        doAddClass:function(objectid, classname){
            if(this.getObj(objectid)){
                if(!this.getObj(objectid).hasClass(classname)){    
                    this.getObj(objectid).addClass(classname);
                }
            }
            else{
                console.log("IMPORTANT " + objectid + " is undefined");
            }
        },

        widenContainer:function(){
            let containers = document.getElementsByClassName("container");

            for(var i=0; i<containers.length; i++){
                containers[i].style.margin = "0px";
                containers[i].style.maxWidth = "99%";
                containers[i].style.padding = "10px";
            }
        },

        addElement:function(el){
            this.elementsToCreate.push(el);
        },

        create:function(){
            this.setBody("");
            for(var i = 0; i < this.elementsToCreate.length;i++ ){
                this.AddToBody(this.elementsToCreate[i]);
            }
            this.elementsToCreate=[];
        },

        replaceEmptyChar:function(input){
            return input.replace(/ /g,"");
        },

        searchDropDown:function(obj,objid2search,additionalFunction){
            let originalValue = this.getObj(objid2search)[0].value;

            if(originalValue == -9999){
                this.doAddClass(obj.id, this.classAllowBlank);
            }
            else{
                this.deleteClass(obj.id, this.classAllowBlank)
                let originalValueExists = true;
                let entriesFound=0;
                let firstEntryobject = undefined;
                let entry9999found = false;
    
                let objval = this.getObj(obj.id)[0].value;
    
                objvalReplaced = this.replaceEmptyChar(objval);
    
                if(this.getObj(objid2search)){
                    this.getObj(objid2search + " option").each(function(){
                        if(objvalReplaced !== ""){
                            if($(this).html().toLowerCase().indexOf(objval.toLowerCase()) !== -1 || $(this)[0].value == -9999){
                                $(this).show();
                                entriesFound++;
    
                                if(firstEntryobject === undefined && $(this)[0].value != -9999){
                                    firstEntryobject = $(this);
                                }
                                else if($(this)[0].value != -9999){
                                    entry9999found=true;
                                }
                            }
                            else{
    
                                if($(this)[0].value == originalValue){
                                    originalValueExists = false;
                                }
    
                                $(this).hide();
                            }
                        }
                        else{
                            $(this).show();
                            entriesFound++;
                            if(firstEntryobject === undefined && $(this)[0].value != -9999){
                                firstEntryobject = $(this);
                            }
                            else if($(this)[0].value != -9999){
                                entry9999found=true;
                            }
                        }                    
                    });
                }
                if(entriesFound == 0){
                    this.getObj(objid2search)[0].value = "";
                }
                else{
                    if(!originalValueExists){
                        if(firstEntryobject !== undefined){
                            if(firstEntryobject[0].value != ""){
                                this.getObj(objid2search)[0].value = firstEntryobject[0].value;
                            }
                            else if(entry9999found == true){
                                this.getObj(objid2search)[0].value = -9999;
                            }
                            else{
                                this.getObj(objid2search)[0].value = "";
                            }
                        }
                        else{
                            this.getObj(objid2search)[0].value = "";
                        }
                        
                        
                    }
                }
            }
            if(window[additionalFunction.split("(")[0]] !== undefined){
                eval(additionalFunction);            
            }
            
        },    
        SearchableDropDownChange:function(obj, additionalFunction){
            let newValue = this.getObj(obj.id)[0].value;
            if(newValue == -9999){
                this.doAddClass("search_"+obj.id, this.classAllowBlank);
            }
            else{
                this.deleteClass("search_"+obj.id, this.classAllowBlank);
                this.deleteClass("search_"+obj.id, "form-invalid");
            }

            
            if(window[additionalFunction.split("(")[0]] !== undefined){
                eval(additionalFunction);
            }
            


        }
    });
})();

var DBG = DaBurnerGermany;
