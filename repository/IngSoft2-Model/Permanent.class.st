"
Made for a Card hierarchy: the Permanent ones can only be played during the turn of the player that wants to use them.
"
Class {
	#name : #Permanent,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Permanent >> applyEffectOverATarget: aTarget on: theGame [
	^ self subclassResponsibility.
]

{ #category : #accessing }
Permanent >> effect [
	^ effect
]

{ #category : #initialization }
Permanent >> initializeCard [
	^ self subclassResponsibility
]
