class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', new Hand deck.dealPlayer(), deck
    @set 'dealerHand', new Hand deck.dealDealer(), deck, true
