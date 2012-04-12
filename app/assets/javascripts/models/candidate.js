$(function() {
	Candidate = Backbone.Model.extend({
		name: 'Candidate',

		urlRoot: '/candidates',
		
		// initialize: function(){
		// 	this.url.bind(function(){
		// 		'candidates/' + this.id;
		// 	});
		// },
		
		inspect: function(){
			alert(JSON.stringify(this.attributes));
		}
	});
});

