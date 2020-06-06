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
DeckHandler >> allDecksAreEmpty [
	decks detect: [ :deck | deck setOfCards isNotEmpty ] ifFound: [ ^false ].
	^true.
]

{ #category : #'as yet unclassified' }
DeckHandler >> deckOf: aPlayer [
	decks detect: [ :deck | deck player == aPlayer ] ifFound: [ :deck | ^deck ] 
]

{ #category : #'as yet unclassified' }
DeckHandler >> decks [
	^ decks
]

{ #category : #'as yet unclassified' }
DeckHandler >> give: aCard to: aPlayer [
	decks
		detect: [ :deck | deck player == aPlayer ]
		ifFound: [ :deck | deck setOfCards add: aCard ]
]

{ #category : #initialization }
DeckHandler >> initializeWith: allThePlayers from: theCardHandler [
	| deckOfAPlayer |
	
	decks := OrderedCollection new.
	allThePlayers do: [ :aPlayer | deckOfAPlayer := Deck for: aPlayer. decks add: deckOfAPlayer.]
]
