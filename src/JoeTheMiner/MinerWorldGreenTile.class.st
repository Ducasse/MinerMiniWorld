Class {
	#name : 'MinerWorldGreenTile',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldGreenTile class >> description [

	^ $E
]

{ #category : 'initialization' }
MinerWorldGreenTile >> initializeColor [

	self color: Color green lighter borderColor: Color green
]

{ #category : 'testing' }
MinerWorldGreenTile >> isGreenTile [

	^ true
]
