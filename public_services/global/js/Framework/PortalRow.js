function PortalRow(properties){
    this.config = {
        id:""
        ,items:{}
    };
    DaBurnerGermany.writePropertiesToObject(properties, this);
}



PortalRow.prototype.create = function(){
    content = '<div class="row rowCustom">';

    for(var i=0; i<this.config.items.length; i++){

        
        content+= '<div class = "col-xl-'+this.config.items[i].width+'">'
        content+= '<div class = "card bg-dark card-portalview">'
        content+= '<div class="card-body">'    
        content+='<h5 class="fw-normal mt-0" title="Number of Customers">' + this.config.items[i].title + '</h5>';

        if(this.config.items[i].items.length>1){
            let width = Math.floor(12/this.config.items[i].items.length);

            content+='<div class="row">';

            for(var j=0; j<this.config.items[i].items.length; j++){
                content+='<div class="col-md-'+width+'">';
                content+='<h3 class="mt-3 mb-3">'+this.config.items[i].items[j].value+'</h3>';
                content+='<p class="mb-0 text-muted">';
                content+='<span class="text-nowrap">'+this.config.items[i].items[j].description+'</span>';
                content+= '</div>';
            }
            content+='</div>';

        }
        else{
            content+='<h3 class="mt-3 mb-3">'+this.config.items[i].items[0].value+'</h3>'
            content+='<p class="mb-0 text-muted">'
            content+='<span class="text-nowrap">'+this.config.items[i].items[0].description+'</span>'
        }
                
        
            
        content+='</div>';
        content+='</div>';
        content+='</div>';


    }
    content+='</div>';



    return content;
}