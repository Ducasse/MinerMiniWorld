"
I hold one tile of each kind. Dragging one of my tiles drops a copy on botWorld.
"
Class {
	#name : 'MinerWorldTilePane',
	#superclass : 'BlElement',
	#instVars : [
		'botWorld'
	],
	#category : 'JoeTheMiner-Board',
	#package : 'JoeTheMiner',
	#tag : 'Board'
}

{ #category : 'initialize' }
MinerWorldTilePane >> addTiles [

	MinerWorldTile subclasses do: [ :each | each paneable ifTrue: [ self addChild: each new ] ]
]

{ #category : 'accessing' }
MinerWorldTilePane >> botWorld [

	^ botWorld
]

{ #category : 'accessing' }
MinerWorldTilePane >> botWorld: aMinerWorld [

	botWorld := aMinerWorld
]

{ #category : 'initialize' }
MinerWorldTilePane >> initialize [

	super initialize.
	self initializeMinerWorldBoardProperties.
	self addTiles
]

{ #category : 'initialize' }
MinerWorldTilePane >> initializeMinerWorldBoardProperties [

	self layout: (BlLinearLayout horizontal cellSpacing: 4).
	self padding: (BlInsets all: 3).
	self border: (BlBorder paint: Color blue lighter width: 1).
	self background: Color blue muchLighter.
	self constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
]
