Class {
	#name : #MoonWalk,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
MoonWalk >> aplicarEfectoCasilleroEn: alguien para: tablero por: rondas [
	| n |
	n := (((Random new) next)*10) asInteger.
	alguien do: [ :player | player move: n*(-1) on: tablero until: rondas ].
]
