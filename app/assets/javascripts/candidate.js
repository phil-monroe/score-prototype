$(function(){
	var candidate = new Candidate($('#candidate').data('json'));
	var availableEvents = new AvailableEvents();

	// Poll every 10 seconds to keep the candidate model up-to-date.
	setInterval(function() {
	  candidate.fetch();
		availableEvents.fetch({data: {user_type: 'Candidate'}});
	}, 10000);
	
	var cand_view = new CandidateView({model: candidate});
	var availEventsView = new AvailableEventsView({collection: availableEvents, user_type: "Candidate"});
});