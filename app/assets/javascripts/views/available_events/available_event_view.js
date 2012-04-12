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
			user_id: 1,
			user_type: this.options.user_type
			});
		event.save({wait: true});
		alert("Submitting " + this.model.get('event_name'));
	},

  render: function() {
		$(this.el).html(this.template({event: this.model}));
    return this;
  }
});