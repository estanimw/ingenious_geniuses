"
A Redo Card.
"
Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Redo >> applyEffectOverATarget: aTarget on: aManagerOfCards [
	| ultimaCarta cartaFinal |
	ultimaCarta := aManagerOfCards lastCardPlayed. "Speed"
	cartaFinal := ultimaCarta creacionDeCarta.
	cartaFinal applyEffectOverATarget: aTarget on: aManagerOfCards.
]
