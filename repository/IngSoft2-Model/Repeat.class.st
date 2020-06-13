"
A Repeat Card.
"
Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Repeat >> applyEffectOverATarget: aTarget on: theGame [
	theGame applyEffectOfLastBoardSlotOn: aTarget
]

{ #category : #initialization }
Repeat >> initializeCard [
	typeOfCard := 'instant'
]
