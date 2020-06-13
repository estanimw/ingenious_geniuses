"
A DeckHandler 
"
Class {
	#name : #DeckHandler,
	#superclass : #Object,
	#instVars : [
		'decks'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckHandler class >> ofPlayers: allThePlayers from: cardHandler [
	^ self new initializeWith: allThePlayers from: cardHandler.
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

{ #category : #accessing }
DeckHandler >> decks [
	^ decks
]

{ #category : #'as yet unclassified' }
DeckHandler >> give: aCard to: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | deck addCardToDeck: aCard ]
]

{ #category : #initialization }
DeckHandler >> initializeWith: allThePlayers from: theCardHandler [
	| deckOfAPlayer firstCard secondCard |
	decks := OrderedCollection new.
	allThePlayers do: [ :aPlayer | 
		deckOfAPlayer := Deck for: aPlayer.
		firstCard := theCardHandler giveCard.
		secondCard := theCardHandler giveCard.
		deckOfAPlayer addCardToDeck: firstCard.
		deckOfAPlayer addCardToDeck: secondCard.
		decks add: deckOfAPlayer.]
]

{ #category : #'as yet unclassified' }
DeckHandler >> pop: aCardClass fromDeckOf: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | 
			deck setOfCards
				detect: [ :aCard | aCard isMemberOf: aCardClass ]
				ifFound: [ :aCard | ^ deck removeCardFromDeck: aCard ]
				ifNone: [ Error signal: 'El jugador no tiene esa carta en su mano' ] ]
]
