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
	decks
		detect: [ :deck | deck setOfCards size ~= 2 ]
		ifFound: [ ^ false ].
	^ true
]

{ #category : #'as yet unclassified' }
DeckHandler >> amountOfCardsOf: aPlayer [
	^ (self deckOf: aPlayer) amountOfCards
]

{ #category : #'as yet unclassified' }
DeckHandler >> deckOf: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | ^ deck ]
]

{ #category : #'as yet unclassified' }
DeckHandler >> generateCardAndAddCardToDeckOfAPlayer: deckOfAPlayer [
	| card |
	card := self giveCard.
	deckOfAPlayer addCardToDeck: card.
]

{ #category : #initialization }
DeckHandler >> generateDeckForEveryPlayerFrom: allThePlayers [
	| deckOfAPlayer |
	allThePlayers
		do: [ :aPlayer | 
			deckOfAPlayer := Deck forPlayer: aPlayer.
			self generateCardAndAddCardToDeckOfAPlayer: deckOfAPlayer.
			self generateCardAndAddCardToDeckOfAPlayer: deckOfAPlayer.
			decks add: deckOfAPlayer ]
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
	card := (typesOfCards atRandom: generator) createCard.
	^ card
]

{ #category : #initialization }
DeckHandler >> initializeWith: allThePlayers withCards: aSetOfCards andDistributionGenerator: aGenerator [
	typesOfCards := aSetOfCards.
	generator := aGenerator.
	decks := OrderedCollection new.
	self generateDeckForEveryPlayerFrom: allThePlayers
]

{ #category : #'as yet unclassified' }
DeckHandler >> pop: aCardClass fromDeckOf: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | ^ deck popCardFromDeck: aCardClass ]
]

{ #category : #accessing }
DeckHandler >> typesOfCards [
	^ typesOfCards
]
