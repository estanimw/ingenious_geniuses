"
This is the Object that allows to create a MainDeck instance that is filled with cards distributed accordingly to the given occurrency.
"
Class {
	#name : #MainDeckBuilder,
	#superclass : #Object,
	#instVars : [
		'cardsWithOccurrency',
		'numberOfCardsOfTheDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MainDeckBuilder class >> generateWithSizeOf: numberOfCards [
	^ (self new) initializeMainDeckWithSizeOf: numberOfCards.
]

{ #category : #adding }
MainDeckBuilder >> addEffect: anEffect withOccurrencyOf: anOcurrency [
	| anEffectWithOccurrency |
	cardsWithOccurrency isEmpty
		ifTrue: [ anEffectWithOccurrency := EffectAndOccurrency withEffect: anEffect andOccurrencyOf: anOcurrency ]
		ifFalse: [ anEffectWithOccurrency := self createEffect: anEffect WithOcurrency: anOcurrency ].
	cardsWithOccurrency add: anEffectWithOccurrency
]

{ #category : #building }
MainDeckBuilder >> build [
	| deck aCardsDistribution |
	aCardsDistribution := self loadCardsAccordingToOdd.
	deck := MainDeck generateWithCardDistribution: aCardsDistribution.
	^ deck
]

{ #category : #adding }
MainDeckBuilder >> createEffect: anEffect WithOcurrency: anOcurrency [
	| anOdd anEffectWithOccurrency |
	anOdd := (cardsWithOccurrency at: cardsWithOccurrency  size) occurrency + anOcurrency.
	anEffectWithOccurrency := EffectAndOccurrency withEffect: anEffect andOccurrencyOf: anOdd.
	^ anEffectWithOccurrency
]

{ #category : #initialization }
MainDeckBuilder >> initializeMainDeckWithSizeOf: numberOfCards [
	cardsWithOccurrency := OrderedCollection new.
	numberOfCardsOfTheDeck := numberOfCards
]

{ #category : #utilities }
MainDeckBuilder >> loadCardsAccordingToOdd [
	| aNumber cardDistribution |
	cardDistribution := OrderedCollection new.
	1 to: numberOfCardsOfTheDeck do: [ :number | 
		aNumber := Random new next * 100 asInteger.
		cardsWithOccurrency
			detect:
				[ :anEffectWithOccurrency | aNumber <= anEffectWithOccurrency occurrency ]
			ifFound:
				[ :anEffectWithOccurrency | cardDistribution add: ((anEffectWithOccurrency effect) createCard) ] ].
	^ cardDistribution
]
