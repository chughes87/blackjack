#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', new Hand deck.dealPlayer(), deck
    @set 'dealerHand', new Hand deck.dealDealer(), deck, true

    # @get('playerHand').on 'endGame', =>
      #playerScore = @get 'playerHand'
      #dealerScore = @get 'dealerHand'
      #if playerScore > 21 and dealerScore <= 21
      # @get('dealerHand').show()
