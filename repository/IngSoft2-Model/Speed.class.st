"
A Speed Card.
"
Class {
	#name : #Speed,
	#superclass : #Card,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Speed class >> creacionDeCarta [
	^ (self new) initialize.
]

{ #category : #playing }
Speed >> applyEffectOverATarget: aPlayer on: aManagerOfCards [
	aManagerOfCards addCard: self toPlayer: aPlayer.
]

{ #category : #accessing }
Speed >> effect [
	^ effect
]

{ #category : #initialization }
Speed >> initialize [
	effect := 1.
]
