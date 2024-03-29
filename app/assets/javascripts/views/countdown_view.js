var CountdownView = Backbone.View.extend({
  el: '#countdown',
  current_time: 0,

	initialize: function() {
    this.calc_time = new CalculationTime();
    var timer = this.calc_time;
    setInterval(function(){
      timer.fetch();
    }, 1000);
    this.calc_time.on('change', this.update, this);
	},
	
	update: function(){
      this.current_time = this.calc_time.get('interval');
      this.render();
	},

  render: function() {
    if(this.current_time == -1) this.current_time = 0;
    $(this.el).html("Estimated time left: " + this.current_time--);
  }
});
