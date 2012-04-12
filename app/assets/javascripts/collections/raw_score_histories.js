$(function() {
  RawScoreHistorys = Backbone.Collection.extend({
    model: RawScoreHistory,
    candidate_id: 0,
    initialize: function(models, options){
      this.candidate_id = options.candidate_id;
    },
    url: function(){
      return this.candidate_id + '/raw_score_histories'
    }
  });
});
