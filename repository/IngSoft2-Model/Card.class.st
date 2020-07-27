"
A Card
"
Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Card class >> createCard [
	^ (self new) initializeCard
]

{ #category : #comparing }
Card >> = aCard [
	^ self className = aCard className
]

{ #category : #playing }
Card >> applyEffectOverATarget: aTarget on: theGame [
	^ self subclassResponsibility.
]

{ #category : #validation }
Card >> checkCardIsPermanent [
	^ self isKindOf: Permanent
]

{ #category : #initialization }
Card >> initializeCard [
	^ self subclassResponsibility
]
