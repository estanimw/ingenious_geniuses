"
A Speed Card.
"
Class {
	#name : #Speed,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Speed >> applyEffectOverATarget: aPlayer on: theGame [
	| theManagerOfCards |
	(aPlayer isString) ifFalse: [ Error signal: 'The card Speed must receive a player as a target' ].
	theManagerOfCards := theGame managerOfCardsActive.
	theManagerOfCards addCard: self toPlayer: aPlayer.
]

{ #category : #initialization }
Speed >> initializeCard [
	effect := 1.
	
]
