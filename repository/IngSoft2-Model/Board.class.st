"
This represents a board.
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
	^(self new) initializeWithSlots: anInteger.
]

{ #category : #'instance initialization' }
Board >> initializeWithSlots: anInteger [ 
	slots := anInteger.
]

{ #category : #accessing }
Board >> slots [
	^ slots
]
