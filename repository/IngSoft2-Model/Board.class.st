"
This class represents a board with slots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'slots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withSlots: anInteger [ 
	^ (self new) initializeWithSlots: anInteger.
]

{ #category : #initialization }
Board >> initializeWithSlots: anInteger [
	slots := anInteger.
]

{ #category : #accessing }
Board >> slots [
	^ slots
]
