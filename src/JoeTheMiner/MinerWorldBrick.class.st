Class {
	#name : 'MinerWorldBrick',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldBrick class >> description [

	^ $B
]

{ #category : 'operation' }
MinerWorldBrick >> canPassOverMe: aMiner [

	^ false
]

{ #category : 'initialization' }
MinerWorldBrick >> initializeColor [

	| brickColor |
	brickColor := Color r: 1.0 g: 0.516 b: 0.355.
	self background: brickColor.
	self border: (BlBorder paint: brickColor darker darker width: 4)
]

{ #category : 'testing' }
MinerWorldBrick >> isBrickTile [

	^ true
]
