"
An Acceleration Card.
"
Class {
	#name : #Acceleration,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Acceleration class >> creacionDeCarta [
	^ (self new) initialize.
]

{ #category : #playing }
Acceleration >> applyEffectOverATarget: allThePlayers on: aManagerOfCards [
	aManagerOfCards addCardToAllPlayers: self.
]

{ #category : #accessing }
Acceleration >> effect [
	^ effect
]

{ #category : #initialization }
Acceleration >> initialize [ 
	effect := 1.
]
