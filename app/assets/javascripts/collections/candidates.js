$(function() {
  Candidates = Backbone.Collection.extend({
    model: Candidate,
    url: '/candidates',
    initialize: function(models, options){
    }
  });
});
