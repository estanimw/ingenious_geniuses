Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Overload class >> creacionDeCarta [
	^ (self new) initialize.
]

{ #category : #initialization }
Overload >> initialize [ 
	effect := -2.
	
]
