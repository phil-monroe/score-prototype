$(function(){
	var candidate = new Candidate($('#candidate').data('json'));
	var availableEvents = new AvailableEvents();
  var rawScoreHistories = new RawScoreHistories([], {candidate_id: candidate.id});

	// Poll every 10 seconds to keep the candidate model up-to-date.
	setInterval(function() {
	  candidate.fetch();
		availableEvents.fetch({data: {user_type: candidate.name}});
    rawScoreHistories.fetch();
	}, 1000);
	
	var cand_view = new CandidateView({model: candidate});
	var availEventsView = new AvailableEventsView({collection: availableEvents, user: candidate});

  var rawsocreview = new RawScoreHistoryView({collection: rawScoreHistories});
  rawScoreHistories.fetch();

});
