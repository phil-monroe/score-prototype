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
    },
    
    last_pillar_contriburtions: function(){
      var len = this.models.length;
      var pillars = this.models[len-1].get('pillars');
      var keys = _.keys(pillars);
      index = 1;  
      var ret = _.map(keys, function(key){
        return [index++ -.25, pillars[key]];
      });
      return [{ data: ret,
                bars: { show: true, 
                        barWidth: .5}}];
    },
    
    last_pillar_plot_options: function(){
      var len = this.models.length;
      var pillars = this.models[len-1].get('pillars');
      var keys = _.keys(pillars);
      index = 1;  
      var ret = _.map(keys, function(key){
        return [index++, key];
      });
      return {
              // series: {bars: {show: true, barWidth: 0.9, align: 'center',},},
              xaxis:  {ticks: ret, min: 0.5, max: keys.length +.5},
              yaxis:  {ticks: 0, max: 1}
          };;
    }
  });
});
