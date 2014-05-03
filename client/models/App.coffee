#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'gameScore', [0,0]
    #the 0th element of the gamescore refers to the P1 score, the 1th element refers to the P2 score
    (@get 'playerHand') .on 'stand hit', (isDealer, score) ->
      @updateScore isDealer, score
      do @gameOverCheck
    , @
    (@get 'playerHand') .on 'stand', ->
      do @dealerLogic
    , @

    @set 'gameOver', false
  ,
  updateScore: (isDealer, score) ->
    scoreLength = score.length
    #Aces handling
    if scoreLength > 1 && score[1] < 22 then currentScore = score[1] else currentScore = score[0]
    #get old gamescore
    oldScore = @get 'gameScore'
    #if is dealer update the 1st element of the gameScore Array
    if isDealer?
     oldScore[1] = currentScore
     @set 'gameScore', oldScore
    else
     oldScore[0] = currentScore
     @set 'gameScore', oldScore
    #otherwise update the 0th element
  ,
  gameOverCheck: ->
    if (@get 'gameScore')[0] > 21
      @set 'gameOver',true
      alert 'you lose'
  ,
  newGame: ->
    do @initialize
    @set 'gameOver', false
  ,
  dealerLogic: ->
    console.log 'dealer in control'
    #call the flip function on the first card in the dealer deck
    do @get 'dealerHand'.at(0).flip
    #(@get 'dealerHand').hit


