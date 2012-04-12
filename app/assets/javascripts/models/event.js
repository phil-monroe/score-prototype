$(function() {
	Event = Backbone.Model.extend({
		name: 'Event',

		urlRoot: '/events',

		inspect: function(){
			alert(JSON.stringify(this.attributes));
		}
	});
});

