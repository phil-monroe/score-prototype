$(function() {
	Recruiter = Backbone.Model.extend({
		name: 'Recruiter',

		urlRoot: '/recruiters',

		inspect: function(){
			alert(JSON.stringify(this.attributes));
		}
	});
});

