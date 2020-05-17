"
Model of a Board.
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'numberOfSlots',
		'slotsList'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> ofA: aNumberOfSlots [ 
	^(self new) initializeWith: aNumberOfSlots.
]

{ #category : #object }
Board >> cargarListaCasilleros [
	slotsList := OrderedCollection new.
	1 to: numberOfSlots do: [ :number | slotsList add: (BoardSlot new) ].
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots [ 
	numberOfSlots := aNumberOfSlots.
	
	self cargarListaCasilleros.
]

{ #category : #accessing }
Board >> numberOfSlots [
	^ numberOfSlots
]

{ #category : #accessing }
Board >> slotsList [
	^ slotsList
]
