class Stylejonction.Models.Base extends Backbone.Model
  initialize: ()->
    @ignored_attributes = new Array()
    @.url = @.url.replace ':id', @.id
    
  toJSON: (includeIgnoreAttributes = false) ->
    return _.clone(@attributes) if includeIgnoreAttributes
    #TO ignore associations
    attributes = _.clone(@attributes)
    for atr in @ignored_attributes
      if atr not instanceof Object  then delete attributes[atr] 
    attributes