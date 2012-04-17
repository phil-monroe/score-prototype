var RawScoreHistoryView = Backbone.View.extend({
  el: '#score-history',
  el2: '#avg-score-history',

	initialize: function() {
		_.bindAll(this, 'render');
		this.collection.on('reset', this.render, this);
	},

  render: function() {
     $.plot(  $(this.el), 
              this.collection.last_pillar_contriburtions(),
              this.collection.last_pillar_plot_options());

    $.plot(   $(this.el2), 
              this.collection.average_data(), 
              { series: {
  		                    stack: true,
  		                    lines: { show: true, fill: true, steps: false }},
                yaxis: {  max: 100 }});
  }
});
