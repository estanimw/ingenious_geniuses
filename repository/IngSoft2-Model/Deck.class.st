"
A Deck
"
Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'setOfCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'card handling' }
Deck >> addCardToDeck: aCard [
	setOfCards add: aCard.
]

{ #category : #utilities }
Deck >> amountOfCards [
	^setOfCards size.
]

{ #category : #accessing }
Deck >> setOfCards [
	^setOfCards.
]
