"
A game
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'board',
		'players',
		'winner'
	],
	#classInstVars : [
		'board',
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withBoardAndPlayers: aCollection [ 
	^(self new) initializeWithBoardAndPlayers: aCollection.
]

{ #category : #accessing }
Game >> board [
	^ board
]

{ #category : #'as yet unclassified' }
Game >> chooseNextShift [
	players next.
]

{ #category : #'as yet unclassified' }
Game >> hasAWinner [
	((players current) winner) ifTrue: [ winner := players current ].
	^(players current) winner.
]

{ #category : #initialization }
Game >> initializeWithBoardAndPlayers: aCollection [ 
	board := aCollection removeFirst.
	players := aCollection removeFirst.
	winner := 0.
]

{ #category : #'as yet unclassified' }
Game >> playShift [
	(players current) throwDice.
]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #'as yet unclassified' }
Game >> whoIsTheWinner [
	^winner.
]
