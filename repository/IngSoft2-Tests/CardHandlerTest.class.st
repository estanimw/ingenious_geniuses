Class {
	#name : #CardHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'setOfCards',
		'cards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #calculating }
CardHandlerTest >> calculateAmountOf: anEffect [ 
	| amount |
	amount := 0.
	cards
		do: [ :effect | 
			(effect isMemberOf: anEffect)
				ifTrue: [ amount := amount + 1 ] ].
	^ amount
]

{ #category : #tests }
CardHandlerTest >> completeASetOfCardsWithThe: cardHandler [
	cards := OrderedCollection new.
	60 timesRepeat: [ cards add: cardHandler giveCard ]
]

{ #category : #running }
CardHandlerTest >> setUp [
	setOfCards := { Acceleration. Cancellation. Overload. Redo. Repeat. Speed }.
]

{ #category : #tests }
CardHandlerTest >> testCardHandlerGivesCardsWithAUniformDistribution [
	| cardHandler amountOfAcceleration amountOfOverload amountOfRedo amountOfSpeed amountOfCancellation amountOfRepeat |
	cardHandler := CardHandler withTheFollowingTypeOfCards: setOfCards.
	amountOfAcceleration := OrderedCollection new.
	amountOfOverload := OrderedCollection new.
	amountOfRedo := OrderedCollection new.
	amountOfSpeed := OrderedCollection new.
	amountOfCancellation := OrderedCollection new.
	amountOfRepeat := OrderedCollection new.
	
	1000
		timesRepeat: [ 
			self completeASetOfCardsWithThe: cardHandler.
			amountOfAcceleration add: (self calculateAmountOf: Acceleration).
			amountOfOverload add: (self calculateAmountOf: Overload).
			amountOfRedo add: (self calculateAmountOf: Redo).
			amountOfSpeed add: (self calculateAmountOf: Speed).
			amountOfCancellation add: (self calculateAmountOf: Cancellation).
			amountOfRepeat add: (self calculateAmountOf: Repeat) 
		].
		
	self assert: amountOfAcceleration average rounded equals: 10.
	self assert: amountOfOverload average rounded equals: 10.
	self assert: amountOfRedo average rounded equals: 10.
	self assert: amountOfSpeed average rounded equals: 10.
	self assert: amountOfCancellation average rounded equals: 10.
	self assert: amountOfRepeat average rounded equals: 10
]

{ #category : #tests }
CardHandlerTest >> testCardHandlerHasAllTypesOfCardsAtInitialization [
	| cardHandler |
	cardHandler := CardHandler withTheFollowingTypeOfCards: setOfCards.
	self assert: cardHandler typesOfCards isNotEmpty.
]
