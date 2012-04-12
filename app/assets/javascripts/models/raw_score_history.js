$(function() {
  RawScoreHistory = Backbone.Model.extend({
		name: 'RawScoreHistory',

		inspect: function(){
			alert(JSON.stringify(this.attributes));
		}
	});
});

