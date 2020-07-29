"
Representa el deck para un jugador en particular.
"
Class {
	#name : #DeckOfAPlayer,
	#superclass : #Deck,
	#instVars : [
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeckOfAPlayer class >> madeFor: aPlayer [ 
	^ self new initializeFor: aPlayer
]

{ #category : #initialization }
DeckOfAPlayer >> initializeFor: aPlayer [ 
	player := aPlayer.
	setOfCards := OrderedCollection new.
]

{ #category : #accessing }
DeckOfAPlayer >> player [
	^ player
]

{ #category : #'card handling' }
DeckOfAPlayer >> popCardFromDeck: aCardClass [
	setOfCards
		detect: [ :card | card isMemberOf: aCardClass ]
		ifFound: [ :card | ^ setOfCards remove: card ]
		ifNone: [ Error signal: 'The player doesn`t have that card in his deck' ]
]
