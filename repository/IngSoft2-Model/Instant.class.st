"
Made for a Card hierarchy: the Instant ones can be played whenever the player wants to use them.
"
Class {
	#name : #Instant,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Instant >> applyEffectOverATarget: aTarget on: theGame [
	^ self subclassResponsibility.
]

{ #category : #initialization }
Instant >> initializeCard [
	
]
