$(function() {
AvailableEvents = Backbone.Collection.extend({
  model: AvailableEvent,
	url: '/available_events'
});
});