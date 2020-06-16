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
	(aTarget isString) ifFalse: [ Error signal: 'The card Repeat must receive a player as a target' ].
	theGame updateLastCardPlayed: self AndApplyEffectOfLastBoardSlotOn: aTarget.
]

{ #category : #initialization }
Repeat >> initializeCard [
	typeOfCard := 'instant'
]
