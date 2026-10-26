"
I am a grid of tiles in which miners (robots) move, pick and drop diamonds.

area is an Array of rows; each cell is an OrderedCollection of tiles stacked bottom to top (ground, colored tile, diamonds).

(MinerWorld new installAreaNamed: #area01) openInSpace
"
Class {
	#name : 'MinerWorld',
	#superclass : 'BlElement',
	#instVars : [
		'area',
		'bots',
		'editing',
		'currentSymbol'
	],
	#classInstVars : [
		'tileDescriptions',
		'defaultTileSize'
	],
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'templates' }
MinerWorld class >> allAreaSelectors [

	^ (self class selectors select: [ :each | 'area*' match: each asString ]) asSortedCollection
]

{ #category : 'areas' }
MinerWorld class >> area01 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGDDGGGGGGGGGGGGG
GGGGDDDDGGGGGGGGGGGG
GGGBDDDDBBBBGGGGGGGG
GGGGBDDBGGGGBGGGGGGG
GGGGBDBDGBBGDBGGGGGG
GGGGBGBGGSGBGBGGGGGG
GGGABGGBGGGBGBGGGGGG
GGGAABDGBBBGGBGGGGGG
GGGGAABGGGGGBEGGGGGG
GGGGGAABBBBBEGGGGGGG
GGGGGGYYYYYYGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> area02 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGDGGGGGGGGG
GGGGGGGGGDGDGGGGGGGG
GGGGGGGGDGDGDGGGGGGG
GGGGGGGDGDGDGDGGGGGG
GGGGGGDGDGDGDGDGGGGG
GGGGGDGDGDGDGDGDGGGG
GGGGDGDGDGDGDGDGDGGG
GGGDGDGDGDGDGDGDGGGG
GGGGDGDGDGDGDGDGGGGG
GGGGGDGDGSGDGDGGGGGG
GGGGGGDGDGDGDGGGGGGG
GGGGGGGDGDGDGGGGGGGG
GGGGGGGGDGDGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> area03 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGSGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> area25 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGBBBBBBBBBGGGGG
GGGGGGBGGGGGGGBGGGGG
GBBBBBBGGGGGGGBGGGGG
GBGGGGBBBBGGGGBGGGGG
GBGGGGBGGBGGGGBGGGGG
GBBBGGBGGBGGBBBGGGGG
GGGBGGBBBBGGBGGGGGGG
GGGBGGGGGGGGBGGGGGGG
GGGBGGGGGGGGBGGGGGGG
GGGBBBBGGGBBBGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GBGGGGGGGSGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaMaze [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGBBBBAAABBBGGGGG
GGGGGBGGGAAABGGBGGGG
GGGGGBBGGGGGBGGBGGGG
GGGGGGBGGGGGGGGBGGGG
GGGGGGBGGGGGGBBBGGGG
GGGBBBBBBGGGBGGBGGGG
GGGBGGGGBBBGBGGBGGGG
GGGBGGGGGBGGGGGBGGGG
GGGBGGGGGGGGGGBGGGGG
GGGBBBBBGGGGGGBGGGGG
GGGGGGGBBGBGGBGGGGGG
GGGGGGGGBGBBBGGGGGGG
GGGGGGGGBGBGGGGGGGGG
GGGGGGGGBGBGGGGGGGGG
GGGGGGGGBSBGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaMiniPath [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGAYGGGGGGGG
GGGGGGGGGGGYYGGGGGGG
GGGGGGGGGGGGYGGGGGGG
GGGGGGGGSYYGYGGGGGGG
GGGGGGGGGGYYYGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaMiniPath2 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGAYGGGGGGGG
GGGGGGGGGGGYYGGGGGGG
GGGGGGGGGGGGYGGGGGGG
GGGGGGGSYYYGYGGGGGGG
GGGGGGGGGYGYYGGGGGGG
GGGGGGGGGYYYGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaMiniPathLeft [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGAGGGGGGGGGGGGGGG
GGGGYGGGGGGGGGGGGGGG
GGGGYYGGGGGGGGGGGGGG
GGGGGYGGGGGGGGGGGGGG
GGGGGYYYGGGGGGGGGGGG
GGGGGGGYSGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaPath [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGYYYGGGGGGGGGGG
GGGGGGYGYGGYYYYYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYYYYGGGYGGGG
GYYYYYYGGGGGGGGYGGGG
GYGGGGGGGGGGGGGYGGGG
GYYYYYASYYYYYYGYGGGG
GGGGGGGGGGGGGYGYGGGG
GGGGGGGGGGGGGYGYGGGG
GGGGGGGGGGGGYYGYGGGG
GGGGGGGGGGGGYGGYGGGG
GGGGGGGGGGGGYYYYGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaPathFinder3 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGYGGYGGGGGGGG
GGGGGGGGYYGYYGGGGGGG
GGGGGGGGGYGGYGGGGGGG
GGGGGGGSYYYGYGGGGGGG
GGGGGGGGGYGYYGGGGGGG
GGGGAYYYYYYYGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaPathFinder4 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGYGGYGGGGGGGG
GGGGAGGGYYGYYGGGGGGG
GGGGYGGGGYGGYGGGGGGG
GGGGYYYSYYYGYGGGGGGG
GGGGGGGGGYGYYGGGGGGG
GGGGGYYYYYYYGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaPathFinderTrap2 [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGAGGGGGGGGGGG
GGGGGGGGYGGYGGGGGGGG
GGGGGGGGYYGYYGGGGGGG
GGGGGGGGGYGGYGGGGGGG
GGGGGGGSYYYGYGGGGGGG
GGGGGGGGGYGYYGGGGGGG
GGGGGGGGGYYYGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areaPathNoBorder [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGYYYGGYYYYYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYGGYGGGYGGGG
GGGGGGYGYYYYGGGYGGGG
GGYYYYYGGGGGGGGYGGGG
GGYGGGGGGGGGGGGYGGGG
GGYYYYASYYYYYYGYGGGG
GGGGGGGGGGGGGYGYGGGG
GGGGGGGGGGGGGYGYGGGG
GGGGGGGGGGGGGYGYGGGG
GGGGGGGGGGGGGYYYGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areafoolingAround [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGBGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGBGBGGGBGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGBGGGGGBGGBGGGGGGG
GGGGGGBGGGGGGGBGGGGG
GGGGGGGYGGGYGGGGGGGG
GGBGGGGGGGGGGGGBGGGG
GGGGBGGGGSGGGBGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGBGGGYGGGYGGBGGGGG
GGGGGBGGGBGGGGGGGGGG
GGGGGGGGGGGGGBGGGGGG
GGGGGGBGBGGBGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'areas' }
MinerWorld class >> areatwo [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGDGGGGGGGGG
GGGGGGGGGDGDGGGGGGGG
GGGGGGGGDGDGDGGGGGGG
GGGGGGGDGDGDGDGGGGGG
GGGGGGDGDGDGDGDGGGGG
GGGGGDGDGDGDGDGDGGGG
GGGGDGDGDGDGDGDGDGGG
GGGDGDGDGDGDGDGDGGGG
GGGGDGDGDGDGDGDGGGGG
GGGGGDGDGSGDGDGGGGGG
GGGGGGDGDGDGDGGGGGGG
GGGGGGGDGDGDGGGGGGGG
GGGGGGGGDGDGGGGGGGGG
'
]

{ #category : 'default' }
MinerWorld class >> botZIndex [
	"tiles are at 0, diamonds at 1"

	^ 2
]

{ #category : 'default' }
MinerWorld class >> columnNumber [

	^ 20
]

{ #category : 'default' }
MinerWorld class >> defaultTileSize [

	defaultTileSize ifNil: [ self initializeDefaultTileSize ].
	^ defaultTileSize
]

{ #category : 'default' }
MinerWorld class >> defaultTileSize: aPoint [

	defaultTileSize := aPoint
]

{ #category : 'forTests' }
MinerWorld class >> forTest [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGSGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'templates' }
MinerWorld class >> gatherAllDefinedAreas [

	^ self allAreaSelectors collect: [ :levelSel | self perform: levelSel ]
]

{ #category : 'templates' }
MinerWorld class >> generateTemplate [
	"self generateTemplate"

	^ String new: self tileNumber + self rowNumber streamContents: [ :aStream |
			  self rowNumber timesRepeat: [
					  self columnNumber timesRepeat: [ aStream nextPut: MinerWorldGroundTile description ].
					  aStream nextPut: Character cr ] ]
]

{ #category : 'initialize' }
MinerWorld class >> initialize [
	"self initialize"

	self initializeTileDescriptions.
	self initializeDefaultTileSize
]

{ #category : 'initialize' }
MinerWorld class >> initializeDefaultTileSize [

	defaultTileSize := 28 @ 28
]

{ #category : 'initialize' }
MinerWorld class >> initializeTileDescriptions [
	"self initializeTileDescriptions"

	tileDescriptions := Dictionary new.
	MinerWorldTile allSubclasses do: [ :each | tileDescriptions at: each description put: each ]
]

{ #category : 'forTests' }
MinerWorld class >> oneForTest [

	^ 'GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
GGGGGDDGGGGGGGGGGGGG
GGGGDDDDGGGGGGGGGGGG
GGGBDDDDBBBBGGGGGGGG
GGGGBDDBGGGGBGGGGGGG
GGGGBDBDGBBGDBGGGGGG
GGGGBGBGESGBGBGGGGGG
GGGABGGBGGGBGBGGGGGG
GGGAABDGBBBGGBGGGGGG
GGGGAABGGGGGBEGGGGGG
GGGGGAABBBBBEGGGGGGG
GGGGGGYYYYYYGGGGGGGG
GGGGGGGGGGGGGGGGGGGG
'
]

{ #category : 'default' }
MinerWorld class >> rowNumber [

	^ 17
]

{ #category : 'templates' }
MinerWorld class >> tileClassFromDescription: aCharacter [

	tileDescriptions ifNil: [ self initializeTileDescriptions ].
	^ tileDescriptions at: aCharacter
]

{ #category : 'default' }
MinerWorld class >> tileNumber [

	^ self columnNumber * self rowNumber
]

{ #category : 'default' }
MinerWorld class >> worldSize [

	^ 1 @ 1 extent: self columnNumber @ self rowNumber
]

{ #category : 'drag and drop' }
MinerWorld >> acceptDroppedTile: aTile atGlobal: aPoint [
	"aTile is the dragged copy, aPoint the position of its center in the space"

	| pos |
	(self containsGlobalPoint: aPoint) ifFalse: [ ^ self ].
	pos := self positionToMinerWorldPosition: (self globalPointToLocal: aPoint).
	(self wantsDroppedTile: aTile at: pos) ifFalse: [ ^ self ].
	self placeTile: aTile class new atColumn: pos x row: pos y
]

{ #category : 'diamond' }
MinerWorld >> addDiamondAt: aPoint [

	self placeTile: MinerWorldDiamond new atColumn: aPoint x row: aPoint y
]

{ #category : 'bots' }
MinerWorld >> addMiner: aMiner [

	self addMiner: aMiner at: self startingPlace
]

{ #category : 'bots' }
MinerWorld >> addMiner: aMiner at: aPoint [

	self uiDo: [
			self positionTile: aMiner for: aPoint.
			aMiner botWorld: self.
			bots add: aMiner.
			self addChild: aMiner ]
]

{ #category : 'bots' }
MinerWorld >> bots [

	^ bots
]

{ #category : 'bots' }
MinerWorld >> botsAtStartingPlace [

	| startPlace |
	startPlace := self startingPlace.
	bots do: [ :each | each goTo: startPlace ].
	self botsUpFront
]

{ #category : 'bots' }
MinerWorld >> botsUpFront [
	"bots are drawn above tiles and diamonds"

	bots do: [ :each | each zIndex: self class botZIndex ]
]

{ #category : 'accessing' }
MinerWorld >> cellAt: aPoint [
	"the stack of tiles at column aPoint x and row aPoint y"

	^ (area at: aPoint y) at: aPoint x
]

{ #category : 'accessing' }
MinerWorld >> cellsDo: aBlock [

	area do: [ :row | row do: aBlock ]
]

{ #category : 'default' }
MinerWorld >> columnNumber [

	^ self class columnNumber
]

{ #category : 'areas' }
MinerWorld >> completeRestart [

	self deleteMiners.
	self deleteTiles.
	self initializeArea.
	self initializeMiners.
	self fillWorldWithGround.
	self installWorld: self currentArea
]

{ #category : 'areas' }
MinerWorld >> currentArea [

	^ self class perform: currentSymbol
]

{ #category : 'areas' }
MinerWorld >> currentLevelDescription [

	^ String new: self tileNumber + self rowNumber streamContents: [ :aStream |
			  1 to: self rowNumber do: [ :currentRow |
					  1 to: self columnNumber do: [ :currentColumn |
					  aStream nextPut: (self tileAt: currentColumn @ currentRow) class description ].
					  aStream nextPut: Character cr ] ]
]

{ #category : 'areas' }
MinerWorld >> deleteMiners [

	bots copy do: [ :each | each delete ]
]

{ #category : 'areas' }
MinerWorld >> deleteTiles [

	self cellsDo: [ :each | each do: [ :tile | tile removeFromParent ] ]
]

{ #category : 'editing' }
MinerWorld >> editing [

	editing := true
]

{ #category : 'areas' }
MinerWorld >> emptyArea [

	self deleteTiles.
	self initializeArea.
	self fillWorldWithGround
]

{ #category : 'area filling' }
MinerWorld >> fillWorldWithGround [

	1 to: self rowNumber do: [ :currentRow |
		1 to: self columnNumber do: [ :currentColumn | self placeTile: MinerWorldGroundTile new atColumn: currentColumn row: currentRow ] ]
]

{ #category : 'initialization' }
MinerWorld >> firstArea [

	currentSymbol := self class allAreaSelectors first
]

{ #category : 'accessing' }
MinerWorld >> firstTileAt: aPoint [
	"return the first tile not taking into account diamonds"

	^ (self cellAt: aPoint) reverse detect: [ :each | each isDiamondTile not ]
]

{ #category : 'accessing' }
MinerWorld >> firstTileAt: column at: row [

	^ self firstTileAt: column @ row
]

{ #category : 'initialization' }
MinerWorld >> initialize [
	"(MinerWorld new installAreaNamed: #area01) openInSpace"

	super initialize.
	self initializeBoardLayout.
	self initializeMiners.
	self running.
	self initializeArea.
	self fillWorldWithGround.
	self firstArea.
	self installCurrentArea
]

{ #category : 'initialization' }
MinerWorld >> initializeArea [
	"one OrderedCollection of stacked tiles per cell, rows first"

	area := (1 to: self rowNumber) collect: [ :row | (1 to: self columnNumber) collect: [ :column | OrderedCollection new ] ]
]

{ #category : 'initialization' }
MinerWorld >> initializeBoardLayout [

	self border: (BlBorder paint: Color black width: 2).
	self background: Color blue muchLighter.
	self extent: self class defaultTileSize * (self columnNumber @ self rowNumber).
	self clipChildren: true
]

{ #category : 'initialization' }
MinerWorld >> initializeMiners [

	bots := OrderedCollection new
]

{ #category : 'areas' }
MinerWorld >> installAreaNamed: aSymbol [
	"aSymbol is the name of a class method of MinerWorld that should
	return an area description"

	(self class class selectors includes: aSymbol) ifFalse: [ ^ self ].
	self deleteMiners.
	self deleteTiles.
	self initializeArea.
	self initializeMiners.
	self fillWorldWithGround.
	currentSymbol := aSymbol.
	self installWorld: (self class perform: aSymbol)
]

{ #category : 'areas' }
MinerWorld >> installCurrentArea [

	self installWorld: self currentArea
]

{ #category : 'area filling' }
MinerWorld >> installWorld: aDescription [
	"Create all the tiles as specified by the description"

	| char tile |
	1 to: self rowNumber do: [ :row |
			1 to: self columnNumber do: [ :column |
					char := aDescription at: (self tileDescriptionAtRow: row column: column).
					char = MinerWorldGroundTile description ifFalse: [
							tile := (self class tileClassFromDescription: char) new.
							self placeTile: tile atColumn: column row: row ] ] ]
]

{ #category : 'diamond' }
MinerWorld >> isDiamondAt: aPoint [

	^ (self tileAt: aPoint) isDiamondTile
]

{ #category : 'editing' }
MinerWorld >> isEditing [

	^ editing
]

{ #category : 'areas' }
MinerWorld >> isValid [
	"check wether the world has one and only one starting place"

	| res |
	res := OrderedCollection new.
	self cellsDo: [ :each | res addAll: (each select: [ :tile | tile isStartingTile ]) ].
	^ res size = 1
]

{ #category : 'accessing' }
MinerWorld >> numberOfTiles [

	^ self columnNumber * self rowNumber
]

{ #category : 'ui process' }
MinerWorld >> pauseAfterMove [
	"let the user see the move when a script drives the miners"

	| aSpace |
	aSpace := self space.
	aSpace ifNil: [ ^ self ].
	aSpace isPulseProcessActive ifTrue: [ ^ self ].
	(Delay forMilliseconds: Miner stepDelay) wait
]

{ #category : 'area filling' }
MinerWorld >> placeTile: tile atColumn: currentColumn row: currentRow [
	"place a new tile in the world"

	self positionTile: tile for: currentColumn @ currentRow.
	self tileAt: currentColumn at: currentRow put: tile.
	self addChild: tile
]

{ #category : 'area filling' }
MinerWorld >> positionTile: aTile for: aPoint [
	"place graphically the tile and assign the world coordinates"

	aTile position: self class defaultTileSize * (aPoint - 1).
	aTile botWorldPosition: aPoint.
	aTile botWorld: self
]

{ #category : 'drag and drop' }
MinerWorld >> positionToMinerWorldPosition: aPoint [

	^ aPoint // self class defaultTileSize + (1 @ 1)
]

{ #category : 'accessing' }
MinerWorld >> remove: anObject at: column at: row [

	(self cellAt: column @ row) remove: anObject ifAbsent: [ nil ]
]

{ #category : 'diamond' }
MinerWorld >> removeDiamondAt: aPoint [

	| top |
	top := self tileAt: aPoint.
	self remove: top at: aPoint x at: aPoint y.
	top removeFromParent
]

{ #category : 'bots' }
MinerWorld >> removeMiner: aMiner [

	bots remove: aMiner ifAbsent: [ nil ].
	aMiner botWorld: nil
	"the element is removed via delete"
]

{ #category : 'area filling' }
MinerWorld >> replaceTileBy: newTile atColumn: currentColumn row: currentRow [
	"replace the first non diamond tile, diamonds stay on top of it"

	| oldTile tiles |
	self positionTile: newTile for: currentColumn @ currentRow.
	oldTile := self firstTileAt: currentColumn @ currentRow.
	tiles := self cellAt: currentColumn @ currentRow.
	tiles at: (tiles indexOf: oldTile) put: newTile.
	self addChild: newTile at: (self childIndexOf: oldTile).
	oldTile removeFromParent.
	self botsUpFront
]

{ #category : 'areas' }
MinerWorld >> restart [

	self deleteTiles.
	self initializeArea.
	self fillWorldWithGround.
	self installWorld: self currentArea.
	self botsAtStartingPlace
]

{ #category : 'default' }
MinerWorld >> rowNumber [

	^ self class rowNumber
]

{ #category : 'editing' }
MinerWorld >> running [

	editing := false
]

{ #category : 'accessing' }
MinerWorld >> startingPlace [
	"return the starting place the first one found for now"

	self cellsDo: [ :each | (each anySatisfy: [ :tile | tile isStartingTile ]) ifTrue: [ ^ each last botWorldPosition ] ].
	^ 1 @ 1
]

{ #category : 'accessing' }
MinerWorld >> tileAt: aPoint [

	^ (self cellAt: aPoint) last
]

{ #category : 'accessing' }
MinerWorld >> tileAt: column at: row [

	^ self tileAt: column @ row
]

{ #category : 'accessing' }
MinerWorld >> tileAt: column at: row put: anObject [

	(self cellAt: column @ row) addLast: anObject
]

{ #category : 'area filling' }
MinerWorld >> tileDescriptionAtRow: aRow column: aColumn [
	"Return the index of the character describing the tile at aRow and aColumn"

	"self new tileDescriptionAtRow: 1 column: 1 -> 1"

	"self new tileDescriptionAtRow: 2 column: 1 -> 22"

	"self new tileDescriptionAtRow: 1 column: 2 -> 2"

	^ aColumn + (aRow - 1 * (self columnNumber + 1))
]

{ #category : 'default' }
MinerWorld >> tileNumber [

	^ self class tileNumber
]

{ #category : 'ui process' }
MinerWorld >> uiDo: aBlock [
	"Changes to the element tree must happen in the Bloc pulse process.
	Miner scripts run in another process (a miner controller or a playground),
	so defer aBlock to the space and wait until it is applied"

	| aSpace |
	aSpace := self space.
	aSpace ifNil: [ ^ aBlock value ].
	aSpace isPulseProcessActive ifTrue: [ ^ aBlock value ].
	aSpace deferAndSettle: aBlock
]

{ #category : 'drag and drop' }
MinerWorld >> wantsDroppedTile: aTile at: aPoint [
	"tiles can only be dropped in editing mode, and never on a brick"

	editing ifFalse: [ ^ false ].
	(self class worldSize containsPoint: aPoint) ifFalse: [ ^ false ].
	^ (self tileAt: aPoint) isBrickTile not
]
