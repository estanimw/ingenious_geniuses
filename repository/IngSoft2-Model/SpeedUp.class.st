Class {
	#name : #SpeedUp,
	#superclass : #BoardSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedUp >> aplicarEfectoCasilleroEn: alguien para: tablero por: rondas [
	alguien do: [ :player | player move: 4  on: tablero until: rondas ].
]
