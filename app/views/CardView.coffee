class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="./images/<%= rankName %>-<%= suitName %>.png"</img>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    if @model.get 'revealed' then @$el.html @template @model.attributes
    else @$el.html @template {rankName: 'card', suitName: 'back'}
