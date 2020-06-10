"
A Cancellation Card.
"
Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Cancellation >> applyEffectOverATarget: aTarget on: aManagerOfCards [
	| theCard targetPlayer |
	theCard := aTarget at: 1.
	targetPlayer := aTarget at: 2.
	aManagerOfCards setManejadorCartasAfectandoAUnJugador
		detect: [ :manager | manager player == targetPlayer ]
		ifFound: [ :manager | 
			manager cardsAffectingThePlayer
				detect: [ :card | card isMemberOf: theCard ]
				ifFound: [ :card | 
					manager removeCard: card ] ]
]
