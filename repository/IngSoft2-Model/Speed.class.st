"
A Speed Card.
"
Class {
	#name : #Speed,
	#superclass : #Permanent,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Speed >> applyEffectOverATarget: aPlayer on: theGame [
	| theManagerOfCards |
	(aPlayer isString) ifFalse: [ Error signal: 'The card Speed must receive a player as a target' ].
	theManagerOfCards := theGame managerOfCardsActive.
	theManagerOfCards addCard: self toPlayer: aPlayer.
]

{ #category : #accessing }
Speed >> effect [
	^ effect
]

{ #category : #initialization }
Speed >> initializeCard [
	effect := 1.
	typeOfCard := 'permanent'
]
