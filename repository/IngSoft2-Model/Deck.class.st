"
A Deck
"
Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'player',
		'setOfCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> forPlayer: aPlayer [ 
	^ self new initializeFor: aPlayer
]

{ #category : #'card handling' }
Deck >> addCardToDeck: aCard [
	setOfCards add: aCard. 
]

{ #category : #utilities }
Deck >> amountOfCards [
	^setOfCards size.
]

{ #category : #initialization }
Deck >> initializeFor: aPlayer [ 
	player := aPlayer.
	setOfCards := OrderedCollection new.
]

{ #category : #accessing }
Deck >> player [
	^ player
]

{ #category : #'card handling' }
Deck >> popCardFromDeck: aCardClass [
	setOfCards
		detect: [ :card | card isMemberOf: aCardClass ]
		ifFound: [ :card | ^ setOfCards remove: card ]
		ifNone: [ Error signal: 'The player doesn`t have that card in his deck' ]
]

{ #category : #accessing }
Deck >> setOfCards [
	^setOfCards.
]
