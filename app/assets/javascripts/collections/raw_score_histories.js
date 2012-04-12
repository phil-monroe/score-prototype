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
      var index = 0;
      var data = (_(this.models).map(function(model){
              return [index++, model.get('pillars')[pillar]*100];
            }));
      return {label: pillar, data: data};
    },

    average_data: function(){
      var index = 0;
      var data = (_(this.models).map(function(model){
              return [index++, model.get('score')*100];
            }));
      return [{label: "average", data: data}];
    },
    url: function(){
      return this.candidate_id + '/raw_score_histories'
    }
  });
});
