"
Representa el deck de descarte de cartas (para las ya usadas o canceladas).
"
Class {
	#name : #DiscardDeck,
	#superclass : #Deck,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiscardDeck class >> createDeck [
	^ (self new) initializeDeckDescarte
]

{ #category : #adding }
DiscardDeck >> addCard: aCard [
	setOfCards add: aCard
]

{ #category : #initialization }
DiscardDeck >> initializeDeckDescarte [
	setOfCards := OrderedCollection new.
]

{ #category : #utilities }
DiscardDeck >> shuffleCards [
	setOfCards shuffle
]
