"
A Cancellation Card.
"
Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Cancellation >> applyEffectOverATarget: aTarget on: theGame [
	| theCard targetPlayer theManagerOfCards |
	theManagerOfCards := theGame managerOfEffects.
	theManagerOfCards hayAlMenosUnaCartaPermanenteActiva
		ifTrue: [ theCard := aTarget at: 1.
			targetPlayer := aTarget at: 2.
			theManagerOfCards setManejadorCartasAfectandoAUnJugador
				detect: [ :manager | manager player == targetPlayer ]
				ifFound: [ :manager | 
					manager cardsAffectingThePlayer
						detect: [ :card | card isMemberOf: theCard ]
						ifFound: [ :card | manager removeCard: card ] ] ]
		ifFalse: [ Error signal: 'No hay cartas permanentes activas' ]
]

{ #category : #initialization }
Cancellation >> initializeCard [
	typeOfCard := 'instant'.
]
