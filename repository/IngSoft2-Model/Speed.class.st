Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Speed class >> creacionDeCarta [
	^ (self new) initialize.
]

{ #category : #initialization }
Speed >> initialize [
	effect := 1.
]
