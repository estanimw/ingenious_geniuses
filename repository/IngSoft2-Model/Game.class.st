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
		'managerOfCardsActive',
		'numberOfTurnsPlayed'
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

{ #category : #'card handling' }
Game >> amountOfCardsOf: aPlayer [
	^ deckHandler amountOfCardsOf: aPlayer
]

{ #category : #'card handling' }
Game >> amountOfCardsOnDiscardDeck [
	^ deckHandler amountOfCardsOnDiscardDeck
]

{ #category : #'card handling' }
Game >> amountOfCardsOnMainDeck [
	^ deckHandler amountOfCardsOnMainDeck
]

{ #category : #playing }
Game >> applyEffectOfLastBoardSlotOn: aPlayer [
	| lastSlot |
	lastSlot := board lastSlot.
	lastSlot applyEffectTo: aPlayer from: self
]

{ #category : #playing }
Game >> applyEffectOfTheSlotAtThePositionOfCurrentPlayer [
	board applyEffectOfTheSlotAtThePositionOfPlayer: self currentPlayer from: self
]

{ #category : #calculations }
Game >> calculateTotalRollOfPlayer: player [
	| diceRoll slotsConsecuenceOfTheCardsInGame |
	diceRoll := dice roll.
	slotsConsecuenceOfTheCardsInGame := managerOfCardsActive totalEffectOver: player.
	^ diceRoll + slotsConsecuenceOfTheCardsInGame
]

{ #category : #'turn managing' }
Game >> chooseNextPlayer [
	turnsIterator next
]

{ #category : #'player information' }
Game >> currentPlayer [
	^ turnsIterator current
]

{ #category : #'card handling' }
Game >> giveCard: aCard toPlayer: aPlayer [
	deckHandler give: aCard to: aPlayer
]

{ #category : #'card handling' }
Game >> giveRandomCardToPlayer: aPlayer [
	| card |
	card := deckHandler giveCard.
	deckHandler give: card to: aPlayer
]

{ #category : #accessing }
Game >> hasStarted [
	^ numberOfTurnsPlayed > 0
]

{ #category : #'game status' }
Game >> hasWinner [
	^ leaderBoard thePlayer: self currentPlayer isWinnerForMaking: roundsForTheGameToBeOver
]

{ #category : #initialization }
Game >> initializeWith: allThePlayers with: aDice and: aBoard until: aNumberOfRounds withSetOf: mainDeck [
	board := aBoard.
	players := allThePlayers.
	dice := aDice.
	turnsIterator := CircularIterator cyclingOver: allThePlayers.
	numberOfTurnsPlayed := 0.
	roundsForTheGameToBeOver := aNumberOfRounds.
	leaderBoard := LeaderBoard with: players.
	"deckHandler := DeckHandler ofPlayers: players withTheFollowingTypeOfCards: cards andGenerator: (SequentialNaturalNumberProvider providing: #(1 2 3 4 5 6))."
	deckHandler := DeckHandler ofPlayers: players withMainDeck: mainDeck.
	managerOfCardsActive := ManagerOfTheCardsActiveInGame createFor: players.
]

{ #category : #accessing }
Game >> managerOfCardsActive [
	^ managerOfCardsActive
]

{ #category : #playing }
Game >> move: player ANumberOfSlotsEqualTo: slotsQuantity [
	leaderBoard updateRowOfThis: player inA: slotsQuantity forThis: board.
]

{ #category : #playing }
Game >> moveEveryPlayerButThePlayer: aPlayer aNumberOfSlotsEqualTo: aNumberOfSlots [
	| allThePlayersButAPlayer |
	allThePlayersButAPlayer := self remove: aPlayer from: players.
	allThePlayersButAPlayer
		do:
			[ :player | self move: player ANumberOfSlotsEqualTo: aNumberOfSlots * -1 ]
]

{ #category : #effect }
Game >> moveEveryPlayerToSlotOne [
	| playerCurrentPosition |
	players
		do: [ :player | 
			playerCurrentPosition := self positionOf: player.
			self move: player ANumberOfSlotsEqualTo: (playerCurrentPosition - 1) * -1 ]
]

{ #category : #calculations }
Game >> numberOfCardsAffectingPlayer: aPlayer [ 
	^ managerOfCardsActive numberOfCardsAffectingPlayer: aPlayer
]

{ #category : #calculations }
Game >> numberOfCardsInTheDeckOfPlayer: aPlayer [ 
	^ deckHandler amountOfCardsOf: aPlayer
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
	self hasWinner
		ifFalse: [ self throwDiceOf: self currentPlayer.
			self applyEffectOfTheSlotAtThePositionOfCurrentPlayer.
			leaderBoard updateOrderOfRows.
			numberOfTurnsPlayed := numberOfTurnsPlayed + 1 ].
	self hasWinner
		ifFalse: [ self chooseNextPlayer. self reloadDeckOfTheGameIfNecessary ]
]

{ #category : #'card handling' }
Game >> player: aPlayer playsTheCard: aCardClass onTarget: aTarget [
	| card |
	card := deckHandler pop: aCardClass fromDeckOf: aPlayer.
	card checkCardIsPermanent
		ifTrue: [ aPlayer == self currentPlayer
				ifFalse:
					[ Error signal: 'You can`t play that card because it`s not your turn' ] ].
	card applyEffectOverATarget: aTarget on: self
]

{ #category : #'player information' }
Game >> positionOf: aPlayer [
	^ leaderBoard positionOf: aPlayer
]

{ #category : #'player information' }
Game >> rankingOf: aPlayer [
	^ leaderBoard rankingOf: aPlayer
]

{ #category : #'card handling' }
Game >> reloadDeckOfTheGameIfNecessary [
	deckHandler reloadMainDeckIfNecessary
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
	| slotsQuantityToMove |
	slotsQuantityToMove := self calculateTotalRollOfPlayer: player.
	self move: player ANumberOfSlotsEqualTo: slotsQuantityToMove
]

{ #category : #playing }
Game >> updateLastCardPlayed: aCard AndApplyEffectOfLastBoardSlotOn: aTarget [
	self applyEffectOfLastBoardSlotOn: aTarget.
	managerOfCardsActive updateLastCardPlayed: aCard
]

{ #category : #accessing }
Game >> winner [
	^ leaderBoard winner
]
