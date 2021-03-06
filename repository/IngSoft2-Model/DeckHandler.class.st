"
A DeckHandler 
"
Class {
	#name : #DeckHandler,
	#superclass : #Object,
	#instVars : [
		'decksOfThePlayers',
		'deckOfTheGame',
		'deckDiscard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckHandler class >> ofPlayers: allThePlayers withMainDeck: mainDeck [
	^ (self new) initializeWithPlayers: allThePlayers andMainDeck: mainDeck.
]

{ #category : #validation }
DeckHandler >> allDecksOfPlayersHaveTwoCards [
	decksOfThePlayers
		detect: [ :deck | deck setOfCards size ~= 2 ]
		ifFound: [ ^ false ].
	^ true
]

{ #category : #'card handling' }
DeckHandler >> amountOfCardsOf: aPlayer [
	^ (self deckOf: aPlayer) amountOfCards
]

{ #category : #'card handling' }
DeckHandler >> amountOfCardsOnDiscardDeck [
	^ deckDiscard amountOfCards
]

{ #category : #'card handling' }
DeckHandler >> amountOfCardsOnMainDeck [
	^ deckOfTheGame amountOfCards
]

{ #category : #'card handling' }
DeckHandler >> deckOf: aPlayer [
	decksOfThePlayers
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | ^ deck ]
]

{ #category : #'card handling' }
DeckHandler >> generateCardAndAddCardToDeckOfAPlayer: deckOfAPlayer [
	| card |
	card := self pickCardFromGameDeck.
	deckOfAPlayer addCardToDeck: card.
]

{ #category : #initialization }
DeckHandler >> generateDeckForEveryPlayerFrom: allThePlayers [
	| deckOfAPlayer |
	allThePlayers
		do: [ :aPlayer | 
			deckOfAPlayer := DeckOfAPlayer madeFor: aPlayer.
			self generateCardAndAddCardToDeckOfAPlayer: deckOfAPlayer.
			self generateCardAndAddCardToDeckOfAPlayer: deckOfAPlayer.
			decksOfThePlayers add: deckOfAPlayer ]
]

{ #category : #'card handling' }
DeckHandler >> giveCard: aCard toPlayer: aPlayer [
	decksOfThePlayers
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | deck addCardToDeck: aCard ]
]

{ #category : #initialization }
DeckHandler >> initializeWithPlayers: allThePlayers andMainDeck: mainDeck [
	deckOfTheGame := mainDeck.
	deckDiscard := DiscardDeck createDeck.
	decksOfThePlayers := OrderedCollection new.
	self generateDeckForEveryPlayerFrom: allThePlayers.
]

{ #category : #'card handling' }
DeckHandler >> pickCardFromGameDeck [
	self reloadMainDeckIfNecessary.
	deckOfTheGame setOfCards isEmpty
		ifTrue: [
			^ Error
				signal:
					'A card can´t be taken from the main deck because it´s empty and no cards have been discarded yet.' ]
		ifFalse: [ ^ deckOfTheGame getCard ]
]

{ #category : #'card handling' }
DeckHandler >> pop: aCardClass fromDeckOf: aPlayer [
	| popedCard |
	decksOfThePlayers
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | 
			popedCard := deck popCardFromDeck: aCardClass.
			deckDiscard addCardToDeck: popedCard.
			^ popedCard ]
]

{ #category : #accessing }
DeckHandler >> reloadMainDeckIfNecessary [
	deckOfTheGame setOfCards isEmpty
		ifFalse: [ ^ self ].
	deckDiscard shuffleCards.
	deckDiscard setOfCards
		do: [ :aCard | deckOfTheGame addCardToDeck: aCard ].
	deckDiscard setOfCards removeAll
]
