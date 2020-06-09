Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Acceleration class >> creacionDeCarta [
	^ (self new) initialize.
]

{ #category : #initialization }
Acceleration >> initialize [ 
	effect := 1.
]
