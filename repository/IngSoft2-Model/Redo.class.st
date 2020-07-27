"
A Redo Card.
"
Class {
	#name : #Redo,
	#superclass : #Instant,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Redo >> applyEffectOverATarget: aTarget on: theGame [
	| lastCardPlayed theManagerOfCards |
	theManagerOfCards := theGame managerOfCardsActive.
	lastCardPlayed := theManagerOfCards lastCardPlayed.
	(lastCardPlayed isMemberOf: Card)
		ifTrue: [ Error
				signal:
					'Redo can´t be played because no other cards have been played yet.' ]
		ifFalse: [ lastCardPlayed applyEffectOverATarget: aTarget on: theGame ]
]
