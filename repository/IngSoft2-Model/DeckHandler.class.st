"
A DeckHandler 
"
Class {
	#name : #DeckHandler,
	#superclass : #Object,
	#instVars : [
		'decks',
		'typesOfCards',
		'generator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckHandler class >> ofPlayers: allThePlayers withTheFollowingTypeOfCards: aSetOfCards [
	^ self new
		initializeWith: allThePlayers
		withCards: aSetOfCards
		andDistributionGenerator: SharedRandom globalGenerator
]

{ #category : #'instance creation' }
DeckHandler class >> ofPlayers: allThePlayers withTheFollowingTypeOfCards: aSetOfCards andGenerator: aGenerator [
	^ self new
		initializeWith: allThePlayers
		withCards: aSetOfCards
		andDistributionGenerator: aGenerator
]

{ #category : #'as yet unclassified' }
DeckHandler >> allDecksHaveTwoCards [
	decks detect: [ :deck | (deck setOfCards size) ~= 2 ] ifFound: [ ^false ].
	^true.
]

{ #category : #'as yet unclassified' }
DeckHandler >> amountOfCardsOf: aPlayer [ 
	^(self deckOf: aPlayer) amountOfCards.
]

{ #category : #'as yet unclassified' }
DeckHandler >> deckOf: aPlayer [
	decks detect: [ :deck | deck player == aPlayer ] ifFound: [ :deck | ^deck ] 
]

{ #category : #'as yet unclassified' }
DeckHandler >> give: aCard to: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | deck addCardToDeck: aCard ]
]

{ #category : #'as yet unclassified' }
DeckHandler >> giveCard [
	| card |
	card := (typesOfCards atRandom: generator) create.
	^ card
]

{ #category : #initialization }
DeckHandler >> initializeWith: allThePlayers withCards: aSetOfCards andDistributionGenerator: aGenerator [
	| deckOfAPlayer firstCard secondCard |
	typesOfCards := aSetOfCards.
	generator := aGenerator.
	decks := OrderedCollection new.
	allThePlayers
		do: [ :aPlayer | 
			deckOfAPlayer := Deck for: aPlayer.
			firstCard := self giveCard.
			secondCard := self giveCard.
			deckOfAPlayer addCardToDeck: firstCard.
			deckOfAPlayer addCardToDeck: secondCard.
			decks add: deckOfAPlayer ]
]

{ #category : #'as yet unclassified' }
DeckHandler >> pop: aCard fromDeckOf: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | ^deck popCardFromDeck: aCard ].
"			deck setOfCards
				detect: [ :aCard | aCard isMemberOf: aCardClass ]
				ifFound: [ :aCard | ^ deck removeCardFromDeck: aCard ]
				ifNone: [ Error signal: 'El jugador no tiene esa carta en su mano' ] ]"
]

{ #category : #accessing }
DeckHandler >> typesOfCards [
	^typesOfCards 
]
