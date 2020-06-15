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

{ #category : #'as yet unclassified' }
Game >> amountOfCardsOf: aPlayer [ 
	^deckHandler amountOfCardsOf: aPlayer.
]

{ #category : #'as yet unclassified' }
Game >> applyEffectOfLastBoardSlotOn: aPlayer [
	| ultimoSlot |
	ultimoSlot := board ultimoSlot.
	ultimoSlot applyEffectTo: aPlayer from: self.
]

{ #category : #playing }
Game >> applyEffectOfTheSlotAtThePositionOfCurrentPlayer [
	board applyEffectOfTheSlotAtThePositionOfPlayer: self currentPlayer from: self
]

{ #category : #'as yet unclassified' }
Game >> cardsAffectingPlayer: aPlayer [ 
	^ managerOfEffects cardsAffectingPlayer: aPlayer
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
Game >> giveCardToPlayer: aPlayer [
	| card |
	card := deckHandler giveCard.
	deckHandler give: card to: aPlayer.
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
	deckHandler := DeckHandler ofPlayers: players withTheFollowingTypeOfCards: cards andGenerator: (SequentialNaturalNumberProvider providing: #(1 2 3 4 5 6)).
	managerOfEffects := ManagerOfEffectsOfTheCardsInGame createFor: players.
]

{ #category : #accessing }
Game >> managerOfEffects [
	^ managerOfEffects
]

{ #category : #playing }
Game >> move: player ANumberOfSlotsEqualTo: slotsQuantity [
	leaderBoard updateRowOfThis: player inA: slotsQuantity forThis: board.
]

{ #category : #'as yet unclassified' }
Game >> moveEveryPlayerButThePlayer: aPlayer aNumberOfSlotsEqualTo: aNumberOfSlots [
	| allThePlayersButAPlayer |
	allThePlayersButAPlayer := self remove: aPlayer from: players.
	allThePlayersButAPlayer do: [ :player | self move: player ANumberOfSlotsEqualTo: aNumberOfSlots * -1 ]
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
Game >> player: aPlayer playsTheCard: aCard onTarget: aTarget [
	| card |
	card := deckHandler pop: aCard fromDeckOf: aPlayer.
	(card typeOfCard = 'permanent') ifTrue: [ (aPlayer == self currentPlayer) ifFalse: [ Error signal: 'You can`t play that card because it`s not your turn' ] ].
	card applyEffectOverATarget: aTarget on: self.
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

{ #category : #'as yet unclassified' }
Game >> updateLastCardPlayed: aCardClass AndApplyEffectOfLastBoardSlotOn: aTarget [
	self applyEffectOfLastBoardSlotOn: aTarget.
	managerOfEffects updateLastCardPlayed: aCardClass.
]

{ #category : #accessing }
Game >> winner [
	^ leaderBoard winner.
]
