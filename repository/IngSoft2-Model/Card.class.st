"
A Card
"
Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> creacionDeCarta [
	^ self subclassResponsibility
]

{ #category : #accessing }
Card >> effect [
	^ effect
]
