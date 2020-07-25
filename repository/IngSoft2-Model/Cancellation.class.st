"
A Cancellation Card.
"
Class {
	#name : #Cancellation,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Cancellation >> applyEffectOverATarget: aTarget on: theGame [
	| theManagerOfCards |
	(aTarget isCollection)&(aTarget isString ~= true)
		ifTrue: [ (((aTarget at: 1) createCard) isKindOf: Card) & (aTarget at: 2) isString
				ifFalse: [ Error
						signal:
							'The card Cancellation must receive a collection with a Card and a player as a target' ] ]
		ifFalse: [ Error
				signal:
					'The card Cancellation must receive a collection with a Card and a player as a target' ].
	theManagerOfCards := theGame managerOfCardsActive.
	theManagerOfCards cancelCardOnTarget: aTarget
]

{ #category : #initialization }
Cancellation >> initializeCard [
	typeOfCard := 'instant'.
]
