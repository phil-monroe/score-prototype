$(function() {
	AvailableEvent = Backbone.Model.extend({
		name: 'Candidate',

		urlRoot: '/candidates',

		inspect: function(){
			alert(JSON.stringify(this.attributes));
		}
	});
});

