class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="new-game">New Game</button>
    <h3 id="notification"></h3>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()
      @dealerPlay()
    "click .stand-button": -> @endGame()
    "click .new-game": -> @restart()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  say: (words) ->
    @$('#notification').text words
    console.log(words)

  dealerPlay: ->
    hand = @model.get('dealerHand')
    currentScore = hand.totalScore()
    console.log(currentScore)
    if currentScore < 17 then hand.hit()

  endGame: ->
    @dealerPlay()
    @model.get('dealerHand').show()
    dealerScore = @model.get('dealerHand').totalScore()
    playerScore = @model.get('playerHand').totalScore()
    dealerBust = dealerScore > 21
    playerBust = playerScore > 21
    if dealerBust and playerBust
      @say "It's a tie!"
    else if dealerBust
      @say "Dealer bust. Player wins! #{dealerScore} #{playerScore}"
    else if playerBust
      @say "Player bust. Dealer wins! #{dealerScore} #{playerScore}"
    else if dealerScore > playerScore
      @say "Dealer wins! #{dealerScore}"
    else if playerScore > dealerScore
      @say "Player wins! #{playerScore}"

  restart: ->
    @model.get('playerHand').reset @model.get('deck').dealPlayer()
    @model.get('dealerHand').reset @model.get('deck').dealDealer()
    @say ""