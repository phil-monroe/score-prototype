var RawScoreHistoryView = Backbone.View.extend({
  el: '#score-history',
  el2: '#avg-score-history',

	initialize: function() {
		_.bindAll(this, 'render');
		this.collection.on('reset', this.render, this);
	},

  render: function() {
    var len = this.collection.models.length;
    var pillars1 = this.collection.models[len-1].get('pillars');
    var pillars2 = this.collection.models[len-2].get('pillars');

    var colors = ["Red", "Orange", "DarkYellow", "Green", "Blue", "Indigo", "Violet"];
    var index = 0;
    var that = this;
    $(that.el).html("");
    _(pillars1).each(function(val, key){
      $(that.el).append("<li style='color:" + colors[(index++)%colors.length] + "'>" + key + ": " + Math.floor((val-pillars2[key])*15) + "</li>");
    });

    $.plot($(this.el2), this.collection.average_data(), {
  		            series: {
  		                stack: true,
  		                lines: { show: true, fill: true, steps: false }
  		            },
                  yaxis: {
                      max: 100
                  }});
  }
});
