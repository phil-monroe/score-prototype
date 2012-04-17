var EnergyView = Backbone.View.extend({
	el: '#energy',

	initialize: function() {
		this.model.on('change', this.render, this);    
	},

  render: function() {
		$(this.el).progressbar( "value" , this.model.get('energy') );
    this.disableButtons();
  },
  
  disableButtons: function(){
    if(this.model.get('energy') == 0){
      $('button').attr("disabled", "disabled");
    }else{
      $('button').removeAttr("disabled");
    }
    
    
  }
});
