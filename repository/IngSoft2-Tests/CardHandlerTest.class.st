Class {
	#name : #CardHandlerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardHandlerTest >> testDistribucionAtRandomEsUniformeYDarCarta [
	| handler setOfCards cartasCargadas amountOfAcceleration amountOfOverload collOver collAcce collRedo amountOfRedo collSpeed collCanc collRepeat amountOfSpeed amountOfCancellation amountOfRepeat |
	setOfCards := { Acceleration. Cancellation. Overload. Redo. Repeat. Speed }.
	handler := CardHandler withTheValidCards: setOfCards.
	cartasCargadas := OrderedCollection new.
	collAcce := OrderedCollection new. collOver := OrderedCollection new. collRedo := OrderedCollection new. collSpeed := OrderedCollection new. collCanc := OrderedCollection new. collRepeat := OrderedCollection new.
	
	1000 timesRepeat: [
		amountOfAcceleration := 0. amountOfOverload := 0. amountOfRedo := 0. amountOfSpeed := 0. amountOfCancellation := 0. amountOfRepeat := 0.
		cartasCargadas := OrderedCollection new.
		60 timesRepeat: [ 
		cartasCargadas add: (setOfCards atRandom) new. ].
		cartasCargadas do: [ :card | (card isMemberOf: Acceleration) ifTrue: [ amountOfAcceleration := amountOfAcceleration + 1 ]. (card isMemberOf: Overload) ifTrue: [ amountOfOverload := amountOfOverload + 1  ]. (card isMemberOf: Redo) ifTrue: [ amountOfRedo  := amountOfRedo + 1  ]. (card isMemberOf: Speed) ifTrue: [ amountOfSpeed := amountOfSpeed + 1  ]. (card isMemberOf: Cancellation) ifTrue: [ amountOfCancellation := amountOfCancellation + 1  ]. (card isMemberOf: Repeat) ifTrue: [ amountOfRepeat := amountOfRepeat + 1  ]  ].
		collAcce add: amountOfAcceleration.
		collOver add: amountOfOverload.
		collRedo add: amountOfRedo.
		collSpeed add: amountOfSpeed.
		collRepeat add: amountOfRepeat.
		collCanc add: amountOfCancellation.
		].
	
	self assert: (collAcce average) rounded equals: 10.
	self assert: (collOver average) rounded equals: 10.
	self assert: (collRedo average) rounded equals: 10.
	self assert: (collRepeat average) rounded equals: 10.
	self assert: (collSpeed average) rounded equals: 10.
	self assert: (collCanc average) rounded equals: 10.
]

{ #category : #tests }
CardHandlerTest >> testInicializaElHandler [
	| handler setOfCards |
	setOfCards := { Acceleration. Cancellation. Overload. Redo. Repeat. Speed }.
	handler := CardHandler withTheValidCards: setOfCards.
	self assert: handler typesOfCards isNotEmpty.
]
