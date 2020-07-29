"
An Overload Card.
"
Class {
	#name : #Overload,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Overload >> applyEffectOverATarget: aPlayer on: theGame [
	| theManagerOfCards |
	(aPlayer isString) ifFalse: [ Error signal: 'The card Overload must receive a player as a target' ].
	theManagerOfCards := theGame managerOfCardsActive.
	theManagerOfCards addCard: self toPlayer: aPlayer.
]

{ #category : #initialization }
Overload >> initializeCard [
	effect := -2.
	
]
