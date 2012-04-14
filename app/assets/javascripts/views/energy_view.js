var EnergyView = Backbone.View.extend({
	el: '#energy',

	initialize: function() {
		this.model.on('change', this.render, this);
	},

  render: function() {
		$(this.el).progressbar( "value" , this.model.get('energy') );
  }
});
