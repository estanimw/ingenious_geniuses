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
Deck >> initializeFor: aPlayer [ 
	player := aPlayer.
	setOfCards := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
Deck >> player [
	^ player
]

{ #category : #'as yet unclassified' }
Deck >> setOfCards [
	^setOfCards.
]
