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
Deck class >> for: aPlayer [ 
	^ self new initializeFor: aPlayer
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
Deck >> popCardFromDeck: aCard [
	(setOfCards includes: aCard) ifTrue: [ ^setOfCards remove: aCard ] ifFalse: [ Error signal: 'The player doesn`t have that card in his deck'  ].
]

{ #category : #accessing }
Deck >> setOfCards [
	^setOfCards.
]
