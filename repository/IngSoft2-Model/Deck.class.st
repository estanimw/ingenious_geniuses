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

{ #category : #'as yet unclassified' }
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

{ #category : #accessing }
Deck >> setOfCards [
	^setOfCards.
]
