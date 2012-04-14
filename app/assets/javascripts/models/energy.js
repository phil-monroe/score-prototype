$(function() {
	Energy = Backbone.Model.extend({
		name: 'Energy',

		urlRoot: function(){return window.candidate.id + '/energy'},

		inspect: function(){
			alert(JSON.stringify(this.attributes));
		}
	});
});

