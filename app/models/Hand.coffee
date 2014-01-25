class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.draw()).last()

  shownScores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  totalScores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + card.get 'value'
    , 0
    if hasAce then [score, score + 10] else [score]

  shownScore: ->
    scores = @shownScores()
    if scores.length is 1 then return scores[0]
    if Math.max(scores...) <= 21 then return Math.max(scores...)
    else return Math.min(scores...)

  totalScore: ->
    scores = @totalScores()
    if scores.length is 1 then return scores[0]
    if Math.max(scores...) <= 21 then return Math.max(scores...)
    else return Math.min(scores...)

  show: ->
    @each ((card) -> if not card.get 'revealed' then card.flip()), this