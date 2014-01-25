class window.Deck extends Backbone.Collection

  model: Card

  initialize: -> @buildDeck()

  buildDeck: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  draw: ->
    result = @pop()
    if @length is 0 then @buildDeck()
    result

  dealPlayer: -> [ @draw(), @draw() ]

  dealDealer: -> [ @draw().flip(), @draw() ]
