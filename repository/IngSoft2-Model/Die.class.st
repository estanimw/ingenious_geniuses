"
This object models a die
"
Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'sides',
		'numberProvider'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validating }
Die class >> assertSidesGreaterThanTwo: aNumberOfSides [

	aNumberOfSides > 1
		ifFalse: [ InstanceCreationFailed signal: 'A die must have at least 2 sides' ]
]

{ #category : #'instance creation - d20 notation' }
Die class >> d10 [
	
	^ self ofASlotDistribution: 10
]

{ #category : #'instance creation - d20 notation' }
Die class >> d100 [

	^ self ofASlotDistribution: 100
]

{ #category : #'instance creation - d20 notation' }
Die class >> d20 [

	^ self ofASlotDistribution: 20
]

{ #category : #'instance creation - d20 notation' }
Die class >> d4 [
	
	^ self ofASlotDistribution: 4
]

{ #category : #'instance creation - d20 notation' }
Die class >> d6 [
	
	^ self ofASlotDistribution: 6
]

{ #category : #'instance creation - d20 notation' }
Die class >> d8 [

	^ self ofASlotDistribution: 8
]

{ #category : #'instance creation' }
Die class >> of: aNumberOfSides rolling: aSequence [

	^ self
		of: aNumberOfSides
		source: (SequentialNaturalNumberProvider providing: aSequence)
]

{ #category : #'instance creation' }
Die class >> of: aNumberOfSides source: aNumberProvider [

	self assertSidesGreaterThanTwo: aNumberOfSides.

	^ self new
		initializeOf: aNumberOfSides
		source: aNumberProvider
]

{ #category : #'instance creation' }
Die class >> ofASlotDistribution: aNumberOfSides [

	^ self of: aNumberOfSides source: Random new
]

{ #category : #composing }
Die >> + aDie [

	^ Dice withAll: {self . aDie}
]

{ #category : #initialization }
Die >> initializeOf: aNumberOfSides source: aNumberProvider [

	sides := aNumberOfSides.
	numberProvider := aNumberProvider
]

{ #category : #rolling }
Die >> roll [

	^ numberProvider nextInt: sides 
]
