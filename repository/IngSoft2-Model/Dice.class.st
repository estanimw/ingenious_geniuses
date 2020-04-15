"
A Dice
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #rolling }
Dice class >> roll [
	^sides atRandom.
]

{ #category : #'instance creation' }
Dice class >> withAll: aDiceSet [
	
	^ self new initializeWithAll: aDiceSet
]

{ #category : #'instance creation' }
Dice class >> withSides: anInteger [ 
	sides := anInteger.
]

{ #category : #composing }
Dice >> + aDie [

	^ Dice withAll: { self . aDie }
]

{ #category : #initialization }
Dice >> initializeWithAll: aDiceSet [
	
	dice := aDiceSet
]

{ #category : #initialization }
Dice >> initializeWithSides: anInteger [ 
	sides := anInteger.
]

{ #category : #rolling }
Dice >> roll [
	
	^ dice sumNumbers: #roll
]
