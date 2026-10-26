Class {
	#name : 'MinerWorldStartTile',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldStartTile class >> description [

	^ $S
]

{ #category : 'initialization' }
MinerWorldStartTile >> initializeColor [

	self color: Color red lighter borderColor: Color red
]

{ #category : 'testing' }
MinerWorldStartTile >> isStartingTile [

	^ true
]
