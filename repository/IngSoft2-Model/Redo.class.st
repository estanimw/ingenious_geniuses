"
A Redo Card.
"
Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Redo >> applyEffectOverATarget: aTarget on: theGame [
	| ultimaCarta cartaFinal theManagerOfCards |
	theManagerOfCards := theGame managerOfEffects.
	ultimaCarta := theManagerOfCards lastCardPlayed. "Speed"
	cartaFinal := ultimaCarta creacionDeCarta.
	cartaFinal applyEffectOverATarget: aTarget on: theGame.
]

{ #category : #initialization }
Redo >> initializeCard [
	typeOfCard := 'instant'
]
