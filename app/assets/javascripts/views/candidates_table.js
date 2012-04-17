var CandidatesTableView = Backbone.View.extend({
	el: '#candidates-table',

	initialize: function() {
		this.collection.on('reset', this.render, this);
	},

  render: function() {
		$(this.el).empty();
		_.each(this.collection.models, this.appendEntry, this);
  },
  
  appendEntry: function(model){
    $(this.el).append(JST['candidates/table_entry']({candidate: model}));
  }
});
