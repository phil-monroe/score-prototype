var AvailableEventsView = Backbone.View.extend({
	el: '#available_events',
  template: window.JST['candidates/show'],

  events: {
  },

	initialize: function() {
		this.collection.on('reset', this.render, this);
		this.collection.fetch({data: {user_type: this.options.user_type}});
	},
	
	appendEntry: function(entry){
		var view = new AvailableEventView({model: entry});
		$('#available_events').append(view.render().el);
	},

  render: function() {
		$(this.el).empty();
		this.collection.each(this.appendEntry);
    return this;
  }
});