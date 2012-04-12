$(function(){
	var recruiter = new Recruiter($('#recruiter').data('json'));
	var availableEvents = new AvailableEvents();

	// Poll every 10 seconds to keep the candidate model up-to-date.
	setInterval(function() {
		availableEvents.fetch({data: {user_type: 'Recruiter'}});
	}, 10000);
	
	var availEventsView = new AvailableEventsView({collection: availableEvents, user: recruiter});
});