Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testCreateBoard [
	| board |
	board := Board withSlots: 30.
	self assert: (board numberOfSlots) equals: 30.
]
