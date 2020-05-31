"
A Board Builder
"
Class {
	#name : #BoardBuilder,
	#superclass : #Object,
	#instVars : [
		'effectsWanted',
		'sizeOfBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardBuilder class >> forABoardOfSize: aNumberOfSlots [
	^(self new) initializeWithSize: aNumberOfSlots
]

{ #category : #adding }
BoardBuilder >> addEffect: anEffect [
	effectsWanted add: anEffect.
]

{ #category : #adding }
BoardBuilder >> addEffect: anEffect withOccurrencyOf: aProbability [
	| effect anOdd |
	effectsWanted isEmpty
		ifTrue: [ effect := EffectAndProbability withEffect: anEffect andOccurrencyOf: aProbability ]
		ifFalse: [ anOdd := (effectsWanted at: effectsWanted size) occurrency + aProbability. effect := EffectAndProbability withEffect: anEffect andOccurrencyOf: anOdd ].
	effectsWanted add: effect
]

{ #category : #building }
BoardBuilder >> build [
	| board aSlotsDistribution |
	aSlotsDistribution := self fillSlotsListWithGivenOccurrencies.
	board := Board of: aSlotsDistribution.
	^ board
]

{ #category : #update }
BoardBuilder >> fillSlotsListWith: effects [
	| effectsAsCircularIterator |
	slotsList := OrderedCollection new.
	effectsAsCircularIterator := CircularIterator cyclingOver: (effects asOrderedCollection).
	
	1 to: numberOfSlots do: [ :number | 
		number % 3 == 0
			ifTrue: [ slotsList add: (effectsAsCircularIterator next) new ]
			ifFalse: [ slotsList add: NoEffect new ] ]
]

{ #category : #update }
BoardBuilder >> fillSlotsListWithGivenOccurrencies [
	| aNumber slotsList |
	slotsList := OrderedCollection new.

	1 to: sizeOfBoard do: [ :number | 
		aNumber := Random new next * 100 asInteger.
		effectsWanted
			detect: [ :anEffect | aNumber <= anEffect occurrency ]
			ifFound: [ :effect | slotsList add: effect effect new ] ].
	
	^ slotsList.
]

{ #category : #initialize }
BoardBuilder >> initializeWithSize: aNumberOfSlots [
	effectsWanted := OrderedCollection new.
	sizeOfBoard := aNumberOfSlots.
]
