"
A Card
"
Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'typeOfCard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Card class >> create [
	^ (self new) initializeCard
]

{ #category : #accessing }
Card >> = aCard [
	^(self className = aCard className)
]

{ #category : #playing }
Card >> applyEffectOverATarget: aTarget on: theGame [
	^ self subclassResponsibility.
]

{ #category : #initialization }
Card >> initializeCard [
	^ self subclassResponsibility
]

{ #category : #accessing }
Card >> typeOfCard [
	^ typeOfCard
]
