class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  # stand: ->
    # @.trigger("endGame")

  shownScores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
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