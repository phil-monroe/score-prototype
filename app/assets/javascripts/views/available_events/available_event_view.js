var AvailableEventView = Backbone.View.extend({
  tagName: 'li',
  template: window.JST['available_events/event'],

  events: {
    "click":          "submitEvent"
  },

	initialize: function() {
		this.model.on('change', this.render, this);
	},
	
	submitEvent: function(entry){
	  if(!window.energy || window.energy.get('energy') != 0){
  		var event = new Event({
  			available_event_id: this.model.id,
  			user_id: this.options.user.id,
  			user_type: this.options.user.name
  			});
  		event.save(null, {success: function(response){
        console.log(response.attributes.energy);
        window.energy.set({energy:response.attributes.energy});}});	    
	  }
	},

  render: function() {
		$(this.el).html(this.template({event: this.model}));
    return this;
  }
});
