"
A Cancellation Card.
"
Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Cancellation >> applyEffectOverATarget: aTarget on: theGame [
	| manager |
	manager := theGame managerOfEffects.
	manager cancelCardOnTarget: aTarget.
]

{ #category : #initialization }
Cancellation >> initializeCard [
	typeOfCard := 'instant'.
]
