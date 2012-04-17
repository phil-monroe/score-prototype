$(function(){
	var recruiter = new Recruiter($('#recruiter').data('json'));
	var availableEvents = new AvailableEvents();
	var candidates = new Candidates();

	// Poll every 10 seconds
	setInterval(function() {
		availableEvents.fetch({data: {user_type: 'Recruiter'}});
		candidates.fetch();
	}, 10000);
	
	var candidatesTable = new CandidatesTableView({collection: candidates})
	var availEventsView = new AvailableEventsView({collection: availableEvents, user: recruiter});
});