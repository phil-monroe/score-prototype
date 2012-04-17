$(function(){

  window.myScore = Math.random()*20 + 60;
  window.energy = new Energy({energy:100});
	window.candidate = new Candidate($('#candidate').data('json'));
  $('#energy').progressbar();
	var availableEvents = new AvailableEvents();
  var rawScoreHistories = new RawScoreHistories([], {candidate_id: candidate.id});
  var timerView = new CountdownView();

	// Poll every 10 seconds to keep the candidate model up-to-date.
	setInterval(function() {
	  timerView.render();
    window.energy.fetch();
	}, 1000);
	
	setInterval(function() {
	  candidate.fetch();
		availableEvents.fetch({data: {user_type: candidate.name}});
    rawScoreHistories.fetch();
	}, 5000);
	var cand_view = new CandidateView({model: candidate});
	var availEventsView = new AvailableEventsView({collection: availableEvents, user: candidate});
  var rawsocreview = new RawScoreHistoryView({collection: rawScoreHistories});
  var energyview = new EnergyView({model: window.energy});
  energyview.render();
  cand_view.render();
  rawScoreHistories.fetch();

});
