"
A Repeat Card.
"
Class {
	#name : #Repeat,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Repeat >> applyEffectOverATarget: aTarget on: theGame [
	(aTarget isString) ifFalse: [ Error signal: 'The card Repeat must receive a player as a target' ].
	(theGame hasStarted) ifFalse: [ Error signal: 'At least one turn must be played before using Repeat card.' ].
	theGame updateLastCardPlayed: self AndApplyEffectOfLastBoardSlotOn: aTarget.
]
