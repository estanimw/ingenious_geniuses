"
This class represents a board with slots
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSlots'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withSlots: slots [ 
	^ (self new) initializeWithSlots: slots.
]

{ #category : #initialization }
Board >> initializeWithSlots: slots [
	numberOfSlots := slots.
]

{ #category : #accessing }
Board >> numberOfSlots [
	^ numberOfSlots.
]
