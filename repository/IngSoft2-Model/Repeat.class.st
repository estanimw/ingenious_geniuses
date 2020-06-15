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
	theGame updateLastCardPlayed: self AndApplyEffectOfLastBoardSlotOn: aTarget.
]

{ #category : #initialization }
Repeat >> initializeCard [
	typeOfCard := 'instant'
]
