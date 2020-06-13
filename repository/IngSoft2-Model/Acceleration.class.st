"
An Acceleration Card.
"
Class {
	#name : #Acceleration,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Acceleration >> applyEffectOverATarget: allThePlayers on: theGame [
	| theManagerOfCards |
	theManagerOfCards := theGame managerOfEffects.
	theManagerOfCards addCardToAllPlayers: self.
]

{ #category : #accessing }
Acceleration >> effect [
	^ effect
]

{ #category : #initialization }
Acceleration >> initializeCard [
	effect := 1.
	typeOfCard := 'permanent'
]
