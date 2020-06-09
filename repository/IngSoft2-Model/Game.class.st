"
This object has the responsability of managing each turn and also delegates to other objects the updates of the LeaderBoard and apply the effects of the slots.
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'roundsForTheGameToBeOver',
		'leaderBoard',
		'turnsIterator',
		'board',
		'dice',
		'deckHandler',
		'cardHandler',
		'managerOfEffects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> playedBy: players thatUse: aDice on: aBoard for: aNumberOfRounds withASetOf: cards [
	"self validateDiceOfAll: players forThis: aBoard."

	^ self new
		initializeWith: players
		with: aDice
		and: aBoard
		until: aNumberOfRounds
		withSetOf: cards
]

{ #category : #validation }
Game class >> validateDiceOfAll: players forThis: board [
	players
		do: [ :player | self validateDiceOfOne: player forThis: board ]
]

{ #category : #validation }
Game class >> validateDiceOfOne: player forThis: board [
	| aDice |
	aDice := player dice.
	aDice dice
		do: [ :die | self validateOne: die OfAPlayerForThis: board ]
]

{ #category : #validation }
Game class >> validateOne: die OfAPlayerForThis: board [
	| sidesOfTheDie condition |
	sidesOfTheDie := die sides.
	condition := sidesOfTheDie
		between: 4
		and: board numberOfSlots * (1 / 3).
	condition
		ifFalse: [ Error signal: 'The die are invalid' ]
]

{ #category : #'as yet unclassified' }
Game >> amountOfCardsOf: aPlayer [ 
	^deckHandler amountOfCardsOf: aPlayer.
]

{ #category : #playing }
Game >> applyEffectOfTheSlotAtThePositionOfCurrentPlayer [
	board applyEffectOfTheSlotAtThePositionOfCurrentPlayerFrom: self.
]

{ #category : #'turn managing' }
Game >> chooseNextPlayer [
	turnsIterator next
]

{ #category : #'player information' }
Game >> currentPlayer [
	^ turnsIterator current
]

{ #category : #'as yet unclassified' }
Game >> giveCard: aCard toPlayer: aPlayer [
	deckHandler give: aCard to: aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> giveCardToCurrentPlayer [
	| card |
	card := cardHandler giveCard.
	deckHandler give: card to: self currentPlayer.
]

{ #category : #'game status' }
Game >> hasWinner [
	^ leaderBoard
		thePlayer: self currentPlayer
		isWinnerForMaking: roundsForTheGameToBeOver
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers with: aDice and: aBoard until: aNumberOfRounds withSetOf: cards [
	board := aBoard.
	players := allThePlayers.
	dice := aDice.
	turnsIterator := CircularIterator cyclingOver: allThePlayers.
	roundsForTheGameToBeOver := aNumberOfRounds.
	leaderBoard := LeaderBoard with: players.
	cardHandler := CardHandler withTheFollowingTypeOfCards: cards.
	deckHandler := DeckHandler ofPlayers: allThePlayers from: cardHandler.
	managerOfEffects := ManagerOfEffectsOfTheCardsInGame crearCon: players.
]

{ #category : #playing }
Game >> move: player ANumberOfSlotsEqualTo: slotsQuantity [
	leaderBoard updateRowOfThis: player inA: slotsQuantity forThis: board.
]

{ #category : #effect }
Game >> moveEveryPlayerButTheCurrentPlayerANumberOfSlotsEqualTo: aNumberOfSlots [
	| allThePlayersButAPlayer player |
	player := self currentPlayer.
	allThePlayersButAPlayer := self remove: player from: players.
	allThePlayersButAPlayer do: [ :aPlayer | self move: aPlayer ANumberOfSlotsEqualTo: aNumberOfSlots * -1 ]
]

{ #category : #effect }
Game >> moveEveryPlayerToSlotOne [
	| playerCurrentPosition |
	 players do: [ :player | 
		playerCurrentPosition := self positionOf: player.
		self move: player ANumberOfSlotsEqualTo: (playerCurrentPosition-1) * -1 ].
]

{ #category : #'player information' }
Game >> numberOfRoundsMadeBy: aPlayer [
	^ leaderBoard roundsMadeBy: aPlayer
]

{ #category : #playing }
Game >> play [
	[ self hasWinner ] whileFalse: [ self playTurn ]
]

{ #category : #'turn managing' }
Game >> playTurn [
	self throwDiceOf: self currentPlayer.
	self applyEffectOfTheSlotAtThePositionOfCurrentPlayer.
	leaderBoard updateOrderOfRows.
	
	self hasWinner
		ifFalse: [ self chooseNextPlayer ]
]

{ #category : #'as yet unclassified' }
Game >> player: aPlayer playsTheCard: aCardClass [ 
	| card |
	card := deckHandler pop: aCardClass fromDeckOf: aPlayer.
	managerOfEffects addCardToAllPlayers: card.
]

{ #category : #'as yet unclassified' }
Game >> player: aPlayer playsTheCard: aCardClass onPlayer: anotherPlayer [
	| card |
	card := deckHandler pop: aCardClass fromDeckOf: aPlayer.
	managerOfEffects addCard: card toPlayer: anotherPlayer.
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #'player information' }
Game >> positionOf: aPlayer [
	^ leaderBoard positionOf: aPlayer
]

{ #category : #'player information' }
Game >> rankingOf: aPlayer [
	^ leaderBoard rankingOf: aPlayer
]

{ #category : #utilities }
Game >> remove: aPlayer from: allThePlayers [
	| allButThePlayer |
	allButThePlayer := allThePlayers copy.
	allButThePlayer remove: aPlayer.
	^ allButThePlayer
]

{ #category : #playing }
Game >> throwDiceOf: player [
	| slotsQuantityToMove diceRoll slotsConsecuenceOfTheCardsInGame |
	diceRoll := dice roll.
	slotsConsecuenceOfTheCardsInGame := managerOfEffects totalEffectOver: player.
	slotsQuantityToMove := diceRoll + slotsConsecuenceOfTheCardsInGame.
	self move: player ANumberOfSlotsEqualTo: slotsQuantityToMove.
]

{ #category : #accessing }
Game >> winner [
	^ leaderBoard winner.
]
