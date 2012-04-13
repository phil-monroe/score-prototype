$(function() {
  RawScoreHistories = Backbone.Collection.extend({
    model: RawScoreHistory,
    candidate_id: 0,
    initialize: function(models, options){
      this.candidate_id = options.candidate_id;
    },

    raw_data_all: function(){
      var that = this;
      return _(this.models[0].get('pillars')).map(function(val, pillar){
        return that.raw_data(pillar);
      });
    },

    raw_data: function(pillar){
      var data = (_(this.models).map(function(model){
              return [model.id, model.get('pillars')[pillar]*100];
            }));
      return {label: pillar, data: data};
    },

    average_data: function(){
      var data = (_(this.models).map(function(model){
              return [model.id, window.myScore + model.get('score')*15];
            }));
      return [{label: "average", data: data}];
    },
    url: function(){
      return this.candidate_id + '/raw_score_histories'
    }
  });
});
