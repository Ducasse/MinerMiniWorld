Class {
	#name : 'MinerWorldMagentaTile',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldMagentaTile class >> description [

	^ $N
]

{ #category : 'initialization' }
MinerWorldMagentaTile >> initializeColor [

	self color: Color magenta lighter borderColor: Color magenta
]

{ #category : 'testing' }
MinerWorldMagentaTile >> isMagentaTile [

	^ true
]
