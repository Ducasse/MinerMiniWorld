Class {
	#name : 'MinerWorldYellowTile',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldYellowTile class >> description [

	^ $Y
]

{ #category : 'initialization' }
MinerWorldYellowTile >> initializeColor [

	self color: Color yellow lighter borderColor: Color yellow
]

{ #category : 'testing' }
MinerWorldYellowTile >> isYellowTile [

	^ true
]
