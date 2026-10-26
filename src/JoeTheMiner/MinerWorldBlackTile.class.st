Class {
	#name : 'MinerWorldBlackTile',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldBlackTile class >> description [

	^ $A
]

{ #category : 'initialization' }
MinerWorldBlackTile >> initializeColor [

	self color: Color black lighter borderColor: Color black
]

{ #category : 'testing' }
MinerWorldBlackTile >> isBlackTile [

	^ true
]
