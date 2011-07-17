class Stylejonction.Models.Base extends Backbone.Model
  initialize: ()->
    @ignored_attributes = new Array()
    
  toJSON: () ->
    #TO ignore associations
    attributes = _.clone(@attributes)
    for atr in @ignored_attributes
      if atr not instanceof Object  then delete attributes[atr] 
    attributes