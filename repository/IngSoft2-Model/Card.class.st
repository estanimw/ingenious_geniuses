"
A Card
"
Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> creacionDeCarta [
	^(self new)
]

{ #category : #playing }
Card >> applyEffectOverATarget: aTarget on: aManagerOfCards [
	^ self subclassResponsibility
]
