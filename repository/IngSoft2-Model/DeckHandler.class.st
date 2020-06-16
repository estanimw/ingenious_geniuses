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

{ #category : #validation }
DeckHandler >> allDecksHaveTwoCards [
	decks
		detect: [ :deck | deck setOfCards size ~= 2 ]
		ifFound: [ ^ false ].
	^ true
]

{ #category : #'card handling' }
DeckHandler >> amountOfCardsOf: aPlayer [
	^ (self deckOf: aPlayer) amountOfCards
]

{ #category : #'card handling' }
DeckHandler >> deckOf: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | ^ deck ]
]

{ #category : #'card handling' }
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

{ #category : #'card handling' }
DeckHandler >> give: aCard to: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | deck addCardToDeck: aCard ]
]

{ #category : #'card handling' }
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

{ #category : #'card handling' }
DeckHandler >> pop: aCardClass fromDeckOf: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | ^ deck popCardFromDeck: aCardClass ]
]

{ #category : #accessing }
DeckHandler >> typesOfCards [
	^ typesOfCards
]
