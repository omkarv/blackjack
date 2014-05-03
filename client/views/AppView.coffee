class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button" disabled>New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .new-game-button": -> @model.newGame()

  initialize: ->
    @render()
    @model.on 'change:gameOver', =>
      gameOver = @model.get 'gameOver'
      if gameOver
        do @greyOut
      else
        do @render
    , this

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  greyOut: ->
    @$('.hit-button').attr('disabled', 'toggle')
    @$('.stand-button').attr('disabled', 'toggle')
    @$('.new-game-button').removeAttr('disabled')
