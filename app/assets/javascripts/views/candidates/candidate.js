var CandidateView = Backbone.View.extend({
	el: '#candidate',
  template: window.JST['candidates/show'],

  events: {
    "click":          "fetchModel",
  },

	initialize: function() {
		_.bindAll(this, 'render');
		this.model.on('change', this.render);
	},
	
	fetchModel: function() {
		this.model.fetch();
	},

  render: function() {
		$(this.el).html(this.template({candidate: this.model}));
  }
});