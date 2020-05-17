Class {
	#name : #AtomicBomb,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AtomicBomb >> aplicarEfectoCasilleroEn: alguien para: tablero por: rondas [
	| posicionActual |
	alguien do: [ :player | posicionActual := player currentPosition. player move: (posicionActual*(-1)) on: tablero until: rondas ].
]
