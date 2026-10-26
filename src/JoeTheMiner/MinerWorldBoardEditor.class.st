"
I am a board to edit areas. Tiles are dragged from the tile pane (or from the world) and dropped on the world; shift-click removes a tile. 'Save Area' compiles the current area as a new area method on MinerWorld class.

MinerWorldBoardEditor open
"
Class {
	#name : 'MinerWorldBoardEditor',
	#superclass : 'MinerWorldBoard',
	#instVars : [
		'tilePane'
	],
	#category : 'JoeTheMiner-Board',
	#package : 'JoeTheMiner',
	#tag : 'Board'
}

{ #category : 'initialization' }
MinerWorldBoardEditor >> createBar [

	| bar |
	bar := self newBar.
	bar addChild: (self createButtonLabel: 'Save Area' target: self actionSelector: #save).
	bar addChild: (self createButtonLabel: 'Area Named' target: self actionSelector: #nextLevelNamed).
	bar addChild: self createAreaMenu.
	bar addChild: (self createButtonLabel: 'Empty' target: self actionSelector: #emptyArea).
	bar addChild: (self createButtonLabel: 'Tile Pane' target: self actionSelector: #openTilePane).
	^ bar
]

{ #category : 'initialization' }
MinerWorldBoardEditor >> defaultBoardColor [

	^ Color blue muchLighter
]

{ #category : 'editing' }
MinerWorldBoardEditor >> emptyArea [

	botWorld emptyArea
]

{ #category : 'initialization' }
MinerWorldBoardEditor >> initialize [
	"MinerWorldBoardEditor open"

	super initialize.
	self border: (BlBorder paint: Color blue width: 1).
	botWorld editing.
	tilePane := MinerWorldTilePane new.
	tilePane botWorld: botWorld.
	tilePane visibility: BlVisibility hidden.
	self addChild: tilePane at: 2
]

{ #category : 'editing' }
MinerWorldBoardEditor >> openTilePane [
	"show or hide the pane from which tiles are dragged on the world"

	tilePane visibility: (tilePane isVisible
			 ifTrue: [ BlVisibility hidden ]
			 ifFalse: [ BlVisibility visible ])
]

{ #category : 'editing' }
MinerWorldBoardEditor >> save [

	| description |
	botWorld isValid ifFalse: [
		^ MinerRequest inform: 'There is too much or no starting place (red tile). There should be only one!' ].
	description := botWorld currentLevelDescription.
	MinerRequest request: 'Give a name for the level' initialAnswer: 'first' do: [ :res |
			res isEmptyOrNil ifFalse: [
				MinerWorld class compile: 'area' , res , String cr , String cr , String tab , '^ ''' , description , '''' classified: 'areas' ] ]
]

{ #category : 'accessing' }
MinerWorldBoardEditor >> title [

	^ 'Miner World Editor'
]
