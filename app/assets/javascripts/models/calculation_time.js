$(function() {
	CalculationTime = Backbone.Model.extend({
		name: 'CalculationTime',

		urlRoot: '/calculation_time_history',

		inspect: function(){
			alert(JSON.stringify(this.attributes));
		}
	});
});

