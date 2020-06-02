Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'aBoard',
		'amountOfNoEffects',
		'amountOfSpeedUp',
		'amountOfWormHole',
		'amountOfMoonWalk',
		'amountOfAtomicBomb',
		'builder'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #calculating }
BoardTest >> calculateAmountOf: anEffect [ 
	| amount |
	amount := 0.
	aBoard slotsList
		do: [ :effect | 
			(effect isMemberOf: anEffect)
				ifTrue: [ amount := amount + 1 ] ].
	^ amount
]

{ #category : #running }
BoardTest >> setUp [
	super setUp.

	builder := BoardBuilder forABoardOfSize: 100.
	builder addEffect: AtomicBomb withOccurrencyOf: 2.
	builder addEffect: NoEffect withOccurrencyOf: 48.
	builder addEffect: SpeedUp withOccurrencyOf: 20. 
	builder addEffect: MoonWalk withOccurrencyOf: 10.
	builder addEffect: WormHole withOccurrencyOf: 20.

	amountOfNoEffects := OrderedCollection new.
	amountOfSpeedUp := OrderedCollection new.
	amountOfWormHole := OrderedCollection new.
	amountOfMoonWalk := OrderedCollection new.
	amountOfAtomicBomb := OrderedCollection new.
]

{ #category : #tests }
BoardTest >> testDistributionOfTheBoard [
		
	1000 timesRepeat: [
		aBoard := builder build.
		amountOfNoEffects add:( self calculateAmountOf: NoEffect).
		amountOfSpeedUp add: (self calculateAmountOf: SpeedUp).
		amountOfWormHole add: (self calculateAmountOf: WormHole).
		amountOfMoonWalk add: (self calculateAmountOf: MoonWalk).
		amountOfAtomicBomb add: (self calculateAmountOf: AtomicBomb).
		].
	self assert: (amountOfNoEffects average) rounded equals: 48.
	self assert: (amountOfSpeedUp average) rounded equals: 20.
	self assert: (amountOfWormHole average) rounded equals: 20.
	self assert: (amountOfMoonWalk average) rounded equals: 10.
	self assert: (amountOfAtomicBomb average) rounded equals: 2.
]
