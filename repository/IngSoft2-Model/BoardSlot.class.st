"
This object has an abstract method so that it´s subclasses have the responsability to override this method according to each subclass funcionality
"
Class {
	#name : #BoardSlot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardSlot class >> createSlot [
	^ self new initializeSlot
]

{ #category : #playing }
BoardSlot >> applyEffectTo: aPlayer from: game [
	^ self subclassResponsibility
]

{ #category : #initialization }
BoardSlot >> initializeSlot [
]
