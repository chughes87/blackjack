class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="new-game">New Game</button>
    <div id="notification"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      if @paused then return
      @model.get('playerHand').hit()
      @dealerPlay()
      if @model.get('playerHand').totalScore() >= 21 || @model.get('dealerHand').totalScore() >= 21
        @endGame()
    "click .stand-button": -> @endGame()
    "click .new-game": -> @restart()

  initialize: ->
    @paused = false
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  say: (words) ->
    @$('#notification').text words

  dealerPlay: ->
    hand = @model.get('dealerHand')
    currentScore = hand.totalScore()
    if currentScore < 17 then hand.hit()

  endGame: ->
    @paused = true
    @dealerPlay()
    @model.get('dealerHand').show()
    dealerScore = @model.get('dealerHand').totalScore()
    playerScore = @model.get('playerHand').totalScore()
    dealerBust = dealerScore > 21
    playerBust = playerScore > 21
    if dealerBust and playerBust
      @say "It's a tie!"
    else if dealerBust
      @say "Dealer bust. Player wins!"
    else if playerBust
      @say "Player bust. Dealer wins!"
    else if dealerScore > playerScore
      @say "Dealer wins!"
    else if playerScore > dealerScore
      @say "Player wins!"
    else
      @say "It's a tie!"

  restart: ->
    @paused = false
    @model.get('playerHand').reset @model.get('deck').dealPlayer()
    @model.get('dealerHand').reset @model.get('deck').dealDealer()
    @say ""