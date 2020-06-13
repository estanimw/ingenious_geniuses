"
An Overload Card.
"
Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Overload >> applyEffectOverATarget: aPlayer on: theGame [
	| theManagerOfCards |
	theManagerOfCards := theGame managerOfEffects.
	theManagerOfCards addCard: self toPlayer: aPlayer.
]

{ #category : #accessing }
Overload >> effect [
	^ effect
]

{ #category : #initialization }
Overload >> initializeCard [
	effect := -2.
	typeOfCard := 'permanent'
]
