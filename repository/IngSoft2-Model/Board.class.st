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
Board class >> of: aNumberOfSlots [
	^ self new initializeWith: aNumberOfSlots
]

{ #category : #'instance creation' }
Board class >> of: aNumberOfSlots with: anEffect [
	^ self new
		initializeWith: aNumberOfSlots
		and: anEffect
]

{ #category : #playing }
Board >> applyEffectOn: aPlayer from: allThePlayers for: aNumberOfRounds [
	| slot |
	slot := self slotAtThePositionOf: aPlayer.
	slot
		applyEffectOfSlotOn: aPlayer
		from: allThePlayers
		forThe: self
		for: aNumberOfRounds
]

{ #category : #update }
Board >> fillSlotsList [
	| aNumber |
	slotsList := OrderedCollection new.
	1 to: numberOfSlots do: [ :number | 
		aNumber := Random new next * 100 asInteger.
		aNumber <= 48
			ifTrue: [ slotsList add: NoEffect new ].
		aNumber > 48 & (aNumber <= 50)
			ifTrue: [ slotsList add: AtomicBomb new ].
		aNumber > 50 & (aNumber <= 60)
			ifTrue: [ slotsList add: MoonWalk new ].
		aNumber > 60 & (aNumber <= 80)
			ifTrue: [ slotsList add: SpeedUp new ].
		aNumber > 80 & (aNumber <= 100)
			ifTrue: [ slotsList add: WormHole new ] ]
]

{ #category : #update }
Board >> fillSlotsListWith: anEffect [
	slotsList := OrderedCollection new.
	1 to: numberOfSlots do: [ :number | 
		number % 4 == 0
			ifTrue: [ slotsList add: anEffect new ]
			ifFalse: [ slotsList add: NoEffect new ] ]
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots [
	numberOfSlots := aNumberOfSlots.
	self fillSlotsList
]

{ #category : #initialization }
Board >> initializeWith: aNumberOfSlots and: anEffect [
	numberOfSlots := aNumberOfSlots.
	self fillSlotsListWith: anEffect.
]

{ #category : #accessing }
Board >> numberOfSlots [
	^ numberOfSlots
]

{ #category : #utilities }
Board >> slotAtThePositionOf: aPlayer [
	^ slotsList at: aPlayer currentPosition
]
