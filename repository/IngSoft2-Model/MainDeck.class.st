"
Representa el mazo principal del juego (de donde se toman cartas).
"
Class {
	#name : #MainDeck,
	#superclass : #Deck,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MainDeck class >> generateWithCardDistribution: listOfCards [
	^ (self new) initializeMainDeckWith: listOfCards.
]

{ #category : #'card handling' }
MainDeck >> getCard [
	^ setOfCards removeFirst.
]

{ #category : #initialization }
MainDeck >> initializeMainDeckWith: listOfCards [
	setOfCards := listOfCards
]
