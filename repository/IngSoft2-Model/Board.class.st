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
Board class >> forTestingOfA: aNumberOfSlots withEffect: anEffect [
	^(self new) initializeForTestingWith: aNumberOfSlots andEffect: anEffect.
]

{ #category : #'instance creation' }
Board class >> ofA: aNumberOfSlots [ 
	^(self new) initializeWith: aNumberOfSlots.
]

{ #category : #object }
Board >> cargarListaCasilleros [
	| num |
	slotsList := OrderedCollection new.
	1 to: numberOfSlots do: [ :number | 
		num := Random new next * 100 asInteger.
		num <= 48
			ifTrue: [ slotsList add: NoEffect new ].
		num > 48 & (num <= 50)
			ifTrue: [ slotsList add: AtomicBomb new ].
		num > 50 & (num <= 60)
			ifTrue: [ slotsList add: MoonWalk new ].
		num > 60 & (num <= 80)
			ifTrue: [ slotsList add: SpeedUp new ].
		num > 80 & (num <= 100)
			ifTrue: [ slotsList add: WormHole new ] ]
]

{ #category : #'as yet unclassified' }
Board >> cargarListaCasillerosForTestingWithEffect: anEffect [
	slotsList := OrderedCollection new.
	1 to: numberOfSlots do: [ :number | 
		number % 4 == 0
			ifTrue: [ slotsList add: anEffect new ]
			ifFalse: [ slotsList add: NoEffect new ] ]
]

{ #category : #initialization }
Board >> initializeForTestingWith: aNumberOfSlots andEffect: anEffect [
	numberOfSlots := aNumberOfSlots.
	self cargarListaCasillerosForTestingWithEffect: anEffect.
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
