"
A Speed Card.
"
Class {
	#name : #Speed,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Speed >> applyEffectOverATarget: aPlayer on: theGame [
	| theManagerOfCards |
	theManagerOfCards := theGame managerOfEffects.
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
