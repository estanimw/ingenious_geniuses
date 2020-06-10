"
An Overload Card.
"
Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Overload class >> creacionDeCarta [
	^ (self new) initialize.
]

{ #category : #playing }
Overload >> applyEffectOverATarget: aPlayer on: aManagerOfCards [
	aManagerOfCards addCard: self toPlayer: aPlayer.
]

{ #category : #accessing }
Overload >> effect [
	^ effect
]

{ #category : #initialization }
Overload >> initialize [ 
	effect := -2.
	
]
