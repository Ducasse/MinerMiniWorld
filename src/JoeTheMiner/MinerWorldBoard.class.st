"
I am the board to play with miners: a button bar on top of a MinerWorld.

Miner controllers are Spec code editors in which each miner of the world is bound to its name.

MinerWorldBoard open
"
Class {
	#name : 'MinerWorldBoard',
	#superclass : 'BlElement',
	#instVars : [
		'botWorld',
		'botControllers',
		'boardColor'
	],
	#category : 'JoeTheMiner-Board',
	#package : 'JoeTheMiner',
	#tag : 'Board'
}

{ #category : 'instance creation' }
MinerWorldBoard class >> open [
	"MinerWorldBoard open"

	| board space |
	board := self new.
	board forceLayout.
	space := BlSpace new.
	space title: board title.
	space extent: board measuredExtent.
	space root addChild: board.
	"the theme changes the size of the buttons once the board is in the space"
	board whenLayoutedDoOnce: [ space extent: board measuredExtent ].
	space show.
	^ space
]

{ #category : 'bot management' }
MinerWorldBoard >> addMiner [

	self inMorphicDo: [
			self requestNewMinerName ifNotNil: [ :name |
					(Miner newInMinerWorld: botWorld) name: name.
					self updateBindings ] ]
]

{ #category : 'bot management' }
MinerWorldBoard >> botBindings [

	| dict |
	dict := Dictionary new.
	botWorld bots do: [ :each | dict at: each name asSymbol put: each ].
	^ dict
]

{ #category : 'accessing' }
MinerWorldBoard >> botControllers [

	^ botControllers
]

{ #category : 'accessing' }
MinerWorldBoard >> botWorld [

	^ botWorld
]

{ #category : 'utilities' }
MinerWorldBoard >> completeRestart [

	botWorld completeRestart.
	self updateBindings
]

{ #category : 'utilities' }
MinerWorldBoard >> createBar [

	| bar |
	bar := self newBar.
	bar addChild: (self createButtonLabel: 'Quit' target: self actionSelector: #delete).
	bar addChild: (self createButtonLabel: 'Pick Area' target: self actionSelector: #selectingArea).
	bar addChild: (self createButtonLabel: 'Restart' target: self actionSelector: #restart).
	bar addChild: (self createButtonLabel: 'Controller' target: self actionSelector: #openMinerController).
	bar addChild: (self createButtonLabel: 'Add Robot' target: self actionSelector: #addMiner).
	^ bar
]

{ #category : 'utilities' }
MinerWorldBoard >> createButtonLabel: label target: target actionSelector: sel [

	^ ToButton new
		  labelText: label;
		  clickAction: [ target perform: sel ];
		  yourself
]

{ #category : 'initialization' }
MinerWorldBoard >> defaultBoardColor [

	^ Color orange
]

{ #category : 'bot controller' }
MinerWorldBoard >> delete [
	"close the board and its controllers"

	| controllers |
	controllers := botControllers copy.
	self inMorphicDo: [ controllers do: [ :each | each closeWindow ] ].
	self space ifNotNil: [ :aSpace | aSpace close ]
]

{ #category : 'utilities' }
MinerWorldBoard >> inMorphicDo: aBlock [
	"Morphic dialogs must not run in the Bloc pulse process"

	UIManager default defer: aBlock
]

{ #category : 'initialization' }
MinerWorldBoard >> initialize [
	"MinerWorldBoard open"

	super initialize.
	self initializeMinerWorldBoardProperties.
	self addChild: self createBar.
	self initializeControllers.
	self initializeMinerWorld
]

{ #category : 'initialization' }
MinerWorldBoard >> initializeControllers [

	botControllers := OrderedCollection new
]

{ #category : 'initialization' }
MinerWorldBoard >> initializeMinerWorld [

	botWorld := MinerWorld new.
	self addChild: botWorld
]

{ #category : 'initialization' }
MinerWorldBoard >> initializeMinerWorldBoardProperties [

	boardColor := self defaultBoardColor.
	self layout: (BlLinearLayout vertical cellSpacing: 1).
	self padding: (BlInsets all: 1).
	self border: (BlBorder paint: boardColor lighter width: 1).
	self background: boardColor.
	self constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]
]

{ #category : 'utilities' }
MinerWorldBoard >> installAreaNamed: aSymbol [

	botWorld uiDo: [ botWorld installAreaNamed: aSymbol ].
	self updateBindings
]

{ #category : 'utilities' }
MinerWorldBoard >> newBar [

	^ BlElement new
		  layout: (BlLinearLayout horizontal cellSpacing: 10);
		  padding: (BlInsets all: 5);
		  background: boardColor;
		  constraintsDo: [ :c |
				  c horizontal fitContent.
				  c vertical fitContent ];
		  yourself
]

{ #category : 'utilities' }
MinerWorldBoard >> nextLevelNamed [

	self inMorphicDo: [
			| name |
			name := UIManager default request: 'Name of the next level' initialAnswer: 'area01'.
			name isEmptyOrNil ifFalse: [ self installAreaNamed: name asSymbol ] ]
]

{ #category : 'bot management' }
MinerWorldBoard >> openMinerController [

	| controller |
	controller := MinerController on: self.
	botControllers add: controller.
	self updateBindings.
	self inMorphicDo: [ controller open ]
]

{ #category : 'bot management' }
MinerWorldBoard >> removeController: aController [

	botControllers remove: aController ifAbsent: [ nil ]
]

{ #category : 'bot management' }
MinerWorldBoard >> requestNewMinerName [
	"ask until the name is not used by another bot, answer nil when cancelled"

	| names name |
	names := botWorld bots collect: [ :each | each name ].
	[
		name := UIManager default request: 'Give a new name for your bot' initialAnswer: 'b' , (Miner botCounter + 1) asString.
		name isEmptyOrNil ifTrue: [ ^ nil ].
		names includes: name ] whileTrue.
	^ name
]

{ #category : 'utilities' }
MinerWorldBoard >> restart [

	botWorld restart
]

{ #category : 'utilities' }
MinerWorldBoard >> selectingArea [

	self inMorphicDo: [
			| defined choice |
			defined := MinerWorld allAreaSelectors asArray.
			choice := UIManager default chooseFrom: defined values: defined title: 'Defined area'.
			choice ifNotNil: [ self installAreaNamed: choice ] ]
]

{ #category : 'accessing' }
MinerWorldBoard >> title [

	^ 'Joe the Miner'
]

{ #category : 'bot management' }
MinerWorldBoard >> updateBindings [

	| bindings |
	bindings := self botBindings.
	botControllers do: [ :each | each setBindings: bindings ]
]
