"
A Board Builder
"
Class {
	#name : #BoardBuilder,
	#superclass : #Object,
	#instVars : [
		'sizeOfBoard',
		'effectsWithOccurrencyWanted'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardBuilder class >> forABoardOfSize: aNumberOfSlots [
	^(self new) initializeWithSize: aNumberOfSlots
]

{ #category : #adding }
BoardBuilder >> addEffect: anEffect withOccurrencyOf: anOcurrency [
	| anEffectWithOccurrency |
	effectsWithOccurrencyWanted isEmpty
		ifTrue: [ anEffectWithOccurrency := EffectAndOccurrency
				withEffect: anEffect
				andOccurrencyOf: anOcurrency ]
		ifFalse: [ anEffectWithOccurrency := self
				createEffect: anEffect
				WithOcurrency: anOcurrency ].
	effectsWithOccurrencyWanted add: anEffectWithOccurrency
]

{ #category : #building }
BoardBuilder >> build [
	| board aSlotsDistribution |
	aSlotsDistribution := self fillSlotsListWithGivenOccurrencies.
	board := Board of: aSlotsDistribution.
	^ board
]

{ #category : #adding }
BoardBuilder >> createEffect: anEffect WithOcurrency: anOcurrency [
	| anOdd anEffectWithOccurrency |
	anOdd := (effectsWithOccurrencyWanted
		at: effectsWithOccurrencyWanted size) occurrency + anOcurrency.
	anEffectWithOccurrency := EffectAndOccurrency
		withEffect: anEffect
		andOccurrencyOf: anOdd.
	^ anEffectWithOccurrency
]

{ #category : #update }
BoardBuilder >> fillSlotsListWithGivenOccurrencies [
	| aNumber slotsList |
	slotsList := OrderedCollection new.
	1 to: sizeOfBoard do: [ :number | 
		aNumber := Random new next * 100 asInteger.
		effectsWithOccurrencyWanted
			detect:
				[ :anEffectWithOccurrency | aNumber <= anEffectWithOccurrency occurrency ]
			ifFound:
				[ :anEffectWithOccurrency | slotsList add: anEffectWithOccurrency effect createSlot ] ].
	^ slotsList
]

{ #category : #initialize }
BoardBuilder >> initializeWithSize: aNumberOfSlots [
	effectsWithOccurrencyWanted := OrderedCollection new.
	sizeOfBoard := aNumberOfSlots.
]
