"
I am the board to play with miners: a button bar on top of a MinerWorld.

Miner controllers are Spec code editors, opened with the Toplo backend, in which each miner of the world is bound to its name.

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

	self addMinerAsking: 'Give a new name for your bot'
]

{ #category : 'bot management' }
MinerWorldBoard >> addMinerAsking: aString [
	"ask again while the name is used by another bot"

	MinerRequest request: aString initialAnswer: 'b' , (Miner botCounter + 1) asString do: [ :name |
			name isEmptyOrNil ifFalse: [
					(botWorld bots anySatisfy: [ :each | each name = name ])
						ifTrue: [ self addMinerAsking: name , ' is already used, give another name' ]
						ifFalse: [ (Miner newInMinerWorld: botWorld) name: name ] ] ]
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

	botWorld completeRestart
]

{ #category : 'utilities' }
MinerWorldBoard >> createAreaMenu [
	"the items are built each time the menu opens, so newly saved areas are listed"

	^ ToMenu new
		  labelText: 'Pick Area';
		  builder: [ :menu |
				  MinerWorld allAreaSelectors do: [ :each |
							  menu addItem: (ToMenuItem new
										   labelText: each;
										   clickAction: [ self installAreaNamed: each ];
										   yourself) ] ];
		  yourself
]

{ #category : 'utilities' }
MinerWorldBoard >> createBar [

	| bar |
	bar := self newBar.
	bar addChild: (self createButtonLabel: 'Quit' target: self actionSelector: #delete).
	bar addChild: self createAreaMenu.
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

	botControllers copy do: [ :each | each close ].
	self space ifNotNil: [ :aSpace | aSpace close ]
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

	botWorld uiDo: [ botWorld installAreaNamed: aSymbol ]
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

	MinerRequest
		request: 'Name of the next level'
		initialAnswer: 'area01'
		do: [ :name | name isEmptyOrNil ifFalse: [ self installAreaNamed: name asSymbol ] ]
]

{ #category : 'bot management' }
MinerWorldBoard >> openMinerController [

	| controller |
	controller := MinerController on: self.
	botControllers add: controller.
	controller open
]

{ #category : 'bot management' }
MinerWorldBoard >> removeController: aController [

	botControllers remove: aController ifAbsent: [ nil ]
]

{ #category : 'utilities' }
MinerWorldBoard >> restart [

	botWorld restart
]

{ #category : 'accessing' }
MinerWorldBoard >> title [

	^ 'Joe the Miner'
]
