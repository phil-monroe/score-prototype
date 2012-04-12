var AvailableEventView = Backbone.View.extend({
  tagName: 'li',
  template: window.JST['available_events/event'],

  events: {
    "click":          "submitEvent",
  },

	initialize: function() {
		this.model.on('change', this.render, this);
	},
	
	submitEvent: function(entry){
		var event = new Event({
			available_event_id: this.model.id,
			user_id: this.options.user.id,
			user_type: this.options.user.name
			});
		event.save({wait: true});
		alert("Submitting " + this.model.get('event_name'));
	},

  render: function() {
		$(this.el).html(this.template({event: this.model}));
    return this;
  }
});