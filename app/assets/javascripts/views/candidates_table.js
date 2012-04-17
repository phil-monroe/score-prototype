var CandidatesTableView = Backbone.View.extend({
	el: '#candidates-table',
	
	events: {
	  'event-sent': "render"
	},

	initialize: function() {
		this.collection.on('reset', this.render, this);
		this.collection.fetch();
		window.dispatcher.on('event', this.render, this);
	},

  render: function() {
		$(this.el).empty();
		_.each(this.collection.models, this.appendEntry, this);
		console.log("rendered")
  },
  
  appendEntry: function(model){
    $(this.el).append(JST['candidates/table_entry']({candidate: model}));
  }
});
