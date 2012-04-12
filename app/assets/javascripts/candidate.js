$(function(){
	var candidate = new Candidate($('#candidate').data('json'));
	var availableEvents = new AvailableEvents();

	// Poll every 10 seconds to keep the candidate model up-to-date.
	setInterval(function() {
	  candidate.fetch();
		availableEvents.fetch({data: {user_type: candidate.name}});
	}, 10000);
	
	var cand_view = new CandidateView({model: candidate});
	var availEventsView = new AvailableEventsView({collection: availableEvents, user: candidate});
	
	$.plot($("#score-history"), [ [[0, 0], [1, 1]] ], { yaxis: { max: 1 } });
});