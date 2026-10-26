"
I am Joe the Miner, a small robot living in a MinerWorld. I can move, turn, sense my surroundings, pick and drop diamonds and paint tiles.

When I live in an opened space, scripts that drive me usually run in the Morphic UI process, so every visual change goes through MinerWorld>>#uiDo:, and #go waits StepDelay milliseconds so that the moves can be seen.
"
Class {
	#name : 'Miner',
	#superclass : 'ToElement',
	#instVars : [
		'botWorldPosition',
		'direction',
		'botWorld',
		'name',
		'diamNumber',
		'vars',
		'bodyColor',
		'head',
		'eye'
	],
	#classVars : [
		'BumpSoundOn',
		'DropSoundOn',
		'MotorSoundOn',
		'PickSoundOn',
		'StepDelay'
	],
	#classInstVars : [
		'botCounter',
		'colorIndex',
		'colorTable'
	],
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'bot counter' }
Miner class >> botCounter [

	botCounter isNil ifTrue: [ botCounter := 0 ].
	^ botCounter
]

{ #category : 'bot counter' }
Miner class >> botCounter: anInteger [

	botCounter := anInteger
]

{ #category : 'bot counter' }
Miner class >> incrementMinerCounter [

	self botCounter: self botCounter + 1
]

{ #category : 'class initialization' }
Miner class >> initialize [
	"self initialize"

	colorIndex := 0.
	colorTable := Color wheel: self maxColor saturation: 0.6 brightness: 1.
	StepDelay := 150.
	self noisy
]

{ #category : 'class initialization' }
Miner class >> maxColor [

	^ 8
]

{ #category : 'instance creation' }
Miner class >> new [

	self incrementMinerCounter.
	^ super new
]

{ #category : 'instance creation' }
Miner class >> newInMinerWorld: aMinerWorld [

	| aMiner |
	aMiner := self new.
	aMinerWorld addMiner: aMiner.
	^ aMiner
]

{ #category : 'class initialization' }
Miner class >> nextColor [
	"compute the next color in the colors"

	colorTable ifNil: [ self initialize ].
	colorIndex := colorIndex + 1 \\ self maxColor + 1.
	^ colorTable at: colorIndex
]

{ #category : 'class initialization' }
Miner class >> noisy [
	"all of the robots will make noise"

	self noisyMotor.
	self noisyDrop.
	self noisyPick.
	self noisyBump
]

{ #category : 'class initialization' }
Miner class >> noisyBump [

	BumpSoundOn := true
]

{ #category : 'class initialization' }
Miner class >> noisyDrop [

	DropSoundOn := true
]

{ #category : 'class initialization' }
Miner class >> noisyMotor [

	MotorSoundOn := true
]

{ #category : 'class initialization' }
Miner class >> noisyPick [

	PickSoundOn := true
]

{ #category : 'class initialization' }
Miner class >> silent [
	"None of the robot will make noise"

	self silentMotor.
	self silentDrop.
	self silentPick.
	self silentBump
]

{ #category : 'class initialization' }
Miner class >> silentBump [

	BumpSoundOn := false
]

{ #category : 'class initialization' }
Miner class >> silentDrop [

	DropSoundOn := false
]

{ #category : 'class initialization' }
Miner class >> silentMotor [

	MotorSoundOn := false
]

{ #category : 'class initialization' }
Miner class >> silentPick [

	PickSoundOn := false
]

{ #category : 'speed' }
Miner class >> stepDelay [
	"milliseconds to wait after each move when a script drives a miner in an opened space"

	^ StepDelay ifNil: [ StepDelay := 150 ]
]

{ #category : 'speed' }
Miner class >> stepDelay: anInteger [
	"Miner stepDelay: 0 for full speed"

	StepDelay := anInteger
]

{ #category : 'initialize' }
Miner >> autoName [

	self name: 'b' , self class botCounter asString
]

{ #category : 'morph' }
Miner >> balloonText [

	^ String streamContents: [ :stream |
			  stream
				  nextPutAll: self name;
				  nextPutAll: ' position: ';
				  print: botWorldPosition;
				  nextPutAll: ' diams: ';
				  print: self diamNumber ]
]

{ #category : 'accessing' }
Miner >> bodyColor [

	^ bodyColor
]

{ #category : 'accessing' }
Miner >> botWorld [

	^ botWorld
]

{ #category : 'accessing' }
Miner >> botWorld: aMinerWorld [

	botWorld := aMinerWorld
]

{ #category : 'accessing' }
Miner >> botWorldPosition [

	^ botWorldPosition
]

{ #category : 'accessing' }
Miner >> botWorldPosition: aPoint [

	botWorldPosition := aPoint
]

{ #category : 'sounds' }
Miner >> bumpSound [

	BumpSoundOn ifTrue: [ self playSound: 'scratch' ]
]

{ #category : 'diamonds' }
Miner >> canDrop [
	"return true if the receiver has still a diamond to drop"

	^ diamNumber > 0
]

{ #category : 'sensors' }
Miner >> canMoveForward [
	"returns true when we can move forward"

	^ (self isNextMoveInWorld: self nextPosition) and: [ self isWallInFront not ]
]

{ #category : 'sensors' }
Miner >> canMoveLeft [
	"returns true when we can move left"

	^ (self isNextMoveInWorld: self leftPosition) and: [ self isWallOnLeft not ]
]

{ #category : 'sensors' }
Miner >> canMoveRight [
	"returns true when we can move right"

	^ (self isNextMoveInWorld: self rightPosition) and: [ self isWallOnRight not ]
]

{ #category : 'diamonds' }
Miner >> canPick [

	^ botWorld isDiamondAt: botWorldPosition
]

{ #category : 'diamonds' }
Miner >> decreaseDiamondNumber [

	self loadDiams: self diamNumber - 1
]

{ #category : 'morph' }
Miner >> delete [

	self inUIDo: [ self removeFromParent ].
	botWorld isNil ifFalse: [ botWorld removeMiner: self ]
]

{ #category : 'accessing' }
Miner >> diamNumber [

	^ diamNumber
]

{ #category : 'accessing' }
Miner >> direction [

	^ direction
]

{ #category : 'accessing' }
Miner >> direction: aPoint [

	direction := aPoint.
	self inUIDo: [ self updateHead ]
]

{ #category : 'diamonds' }
Miner >> drop [
	"drop a diamond on the current position if carrying a diamond"

	self canDrop
		ifTrue: [
				self dropSound.
				self decreaseDiamondNumber.
				self inUIDo: [
						botWorld addDiamondAt: botWorldPosition.
						botWorld botsUpFront ] ]
		ifFalse: [
				self bumpSound.
				self error: self name printString , ' does not have diamond to drop' ]
]

{ #category : 'sounds' }
Miner >> dropSound [

	DropSoundOn ifTrue: [ self playSound: 'scritch' ]
]

{ #category : 'operations' }
Miner >> east [

	self direction: self eastEncoding
]

{ #category : 'private' }
Miner >> eastEncoding [

	^ 1 @ 0
]

{ #category : 'operations' }
Miner >> go [
	"Move the bot one tile in the current direction without
	checking wether it is possible. Raise an error if there is a
	problem "

	| nextPosition |
	nextPosition := self nextPosition.
	(self isNextMoveInWorld: nextPosition) ifFalse: [
			self bumpSound.
			^ self error: 'Alert bot out of limits!' ].
	self isWallInFront
		ifTrue: [
				self bumpSound.
				self error: 'Alert bot bumped into a brick!' ]
		ifFalse: [
				self goTo: nextPosition.
				self motorSound.
				botWorld pauseAfterMove ]
]

{ #category : 'private' }
Miner >> goTo: aPoint [

	botWorldPosition := aPoint.
	self inUIDo: [ self position: (botWorld tileAt: aPoint) position ]
]

{ #category : 'operations' }
Miner >> home [

	self goTo: botWorld startingPlace
]

{ #category : 'private' }
Miner >> inUIDo: aBlock [

	botWorld ifNil: [ ^ aBlock value ].
	botWorld uiDo: aBlock
]

{ #category : 'diamonds' }
Miner >> increaseDiamondNumber [

	self loadDiams: self diamNumber + 1
]

{ #category : 'initialize' }
Miner >> initialize [
	"Miner new openInSpace"

	super initialize.
	bodyColor := self class nextColor.
	self layout: BlBasicLayout new. "ToElement uses a frame layout that ignores the positions of the parts"
	self extent: MinerWorld defaultTileSize.
	self zIndex: MinerWorld botZIndex.
	self initializeShape.
	botWorldPosition := 1 @ 1.
	self north.
	self autoName.
	diamNumber := 0. "No noise when bot is loaded"
	vars := Dictionary new.
	self initializeTooltip.
	self otherInitialize
]

{ #category : 'initialize' }
Miner >> initializeShape [
	"a shaded body, a head pointing to the current direction and an eye"

	| extent body |
	extent := MinerWorld defaultTileSize.
	body := BlElement new
		        geometry: BlEllipseGeometry new;
		        extent: extent - 8;
		        position: 4 @ 4;
		        background: (BlRadialGradientPaint new
				         stops: {
						         (0 -> bodyColor).
						         (1 -> (Color r: bodyColor red * 0.2 g: bodyColor green * 0.2 b: bodyColor blue * 0.2)) };
				         center: extent - 8 / 2;
				         radius: extent x - 8 / 2;
				         yourself);
		        preventMouseEvents;
		        yourself.
	head := BlElement new
		        geometry: BlEllipseGeometry new;
		        extent: (extent y // 3) asPoint;
		        background: Color yellow darker;
		        preventMouseEvents;
		        yourself.
	eye := BlElement new
		       geometry: BlEllipseGeometry new;
		       extent: (extent y // 5) asPoint;
		       background: Color black;
		       preventMouseEvents;
		       yourself.
	self addChildren: {
			body.
			head.
			eye }
]

{ #category : 'initialize' }
Miner >> initializeTooltip [

	self tooltip: [ :aWindow :aRequest | aWindow root addChild: (ToLabel text: self balloonText) ]
]

{ #category : 'sensors' }
Miner >> isAtHome [

	^ (botWorld firstTileAt: self botWorldPosition) isStartingTile
]

{ #category : 'private' }
Miner >> isNextMoveInWorld: aPosition [

	^ botWorld class worldSize containsPoint: aPosition
]

{ #category : 'sensors' }
Miner >> isOnBlack [

	^ (botWorld firstTileAt: self botWorldPosition) isBlackTile
]

{ #category : 'sensors' }
Miner >> isOnBlue [

	^ (botWorld firstTileAt: self botWorldPosition) isGroundTile
]

{ #category : 'sensors' }
Miner >> isOnGreen [

	^ (botWorld firstTileAt: self botWorldPosition) isGreenTile
]

{ #category : 'sensors' }
Miner >> isOnMagenta [

	^ (botWorld firstTileAt: self botWorldPosition) isMagentaTile
]

{ #category : 'sensors' }
Miner >> isOnRed [

	^ (botWorld firstTileAt: self botWorldPosition) isStartingTile
]

{ #category : 'sensors' }
Miner >> isOnYellow [

	^ (botWorld firstTileAt: self botWorldPosition) isYellowTile
]

{ #category : 'variables' }
Miner >> isVariableDefined: aSymbol [
	"Tell whether a variable named aSymbol is defined"

	^ vars includesKey: aSymbol
]

{ #category : 'private' }
Miner >> isWallInFront [

	^ (self nextTile canPassOverMe: self) not
]

{ #category : 'private' }
Miner >> isWallOnLeft [

	^ (self leftTile canPassOverMe: self) not
]

{ #category : 'private' }
Miner >> isWallOnRight [

	^ (self rightTile canPassOverMe: self) not
]

{ #category : 'private' }
Miner >> leftDirectionEncoding [

	| dir |
	dir := self direction.
	^ dir y @ dir x negated
]

{ #category : 'private' }
Miner >> leftPosition [
	"returns the position of the left tile taking into account the
	direction of the bot"

	^ self leftDirectionEncoding + botWorldPosition
]

{ #category : 'private' }
Miner >> leftTile [
	"returns the left tile that should be in the world"

	^ botWorld firstTileAt: self leftPosition
]

{ #category : 'diamonds' }
Miner >> loadDiams: anInteger [

	diamNumber := anInteger.
	self triggerEvent: #diamNumber:
]

{ #category : 'sounds' }
Miner >> motorSound [

	MotorSoundOn ifTrue: [ self playSound: 'motor' ]
]

{ #category : 'accessing' }
Miner >> name [

	^ name
]

{ #category : 'accessing' }
Miner >> name: aString [

	name := aString
]

{ #category : 'private' }
Miner >> nextPosition [

	^ self direction + botWorldPosition
]

{ #category : 'private' }
Miner >> nextTile [
	"return the next tile that should be in the world"

	^ botWorld firstTileAt: self nextPosition
]

{ #category : 'operations' }
Miner >> north [

	self direction: self northEncoding
]

{ #category : 'private' }
Miner >> northEncoding [

	^ 0 @ -1
]

{ #category : 'initialize' }
Miner >> otherInitialize [
	"hook so that people can savely extend the robot"

	self
]

{ #category : 'private' }
Miner >> paint: aClass [
	"the starting place cannot be painted"

	| pos |
	self isAtHome ifTrue: [ ^ self ].
	pos := self botWorldPosition.
	self inUIDo: [ self botWorld replaceTileBy: aClass new atColumn: pos x row: pos y ]
]

{ #category : 'painting' }
Miner >> paintBlack [

	self paint: MinerWorldBlackTile
]

{ #category : 'painting' }
Miner >> paintBlue [

	self paint: MinerWorldGroundTile
]

{ #category : 'painting' }
Miner >> paintGreen [

	self paint: MinerWorldGreenTile
]

{ #category : 'painting' }
Miner >> paintMagenta [

	self paint: MinerWorldMagentaTile
]

{ #category : 'painting' }
Miner >> paintYellow [

	self paint: MinerWorldYellowTile
]

{ #category : 'diamonds' }
Miner >> pick [
	"pick a diamond if possible, else raise an error"

	self canPick
		ifTrue: [
				self pickSound.
				self increaseDiamondNumber.
				self inUIDo: [ botWorld removeDiamondAt: botWorldPosition ] ]
		ifFalse: [
				self bumpSound.
				self error: 'Alert is no diamond to pick up!' ]
]

{ #category : 'sounds' }
Miner >> pickSound [

	PickSoundOn ifTrue: [ self playSound: 'clink' ]
]

{ #category : 'sounds' }
Miner >> playSound: aString [
	"the Sound package is not part of a standard Pharo image, play only when it is loaded"

	Smalltalk
		at: #SampledSound
		ifPresent: [ :soundClass | (soundClass soundNamed: aString) ifNotNil: [ :s | s playAndWaitUntilDone ] ]
]

{ #category : 'operations' }
Miner >> pointRandomly [
	"The receiver points in random direction"

	self direction: self randomDirection
]

{ #category : 'printing' }
Miner >> printOn: aStream [

	aStream nextPutAll: 'Miner '.
	self name isNil ifFalse: [
			aStream
				nextPutAll: self name;
				nextPut: Character space ].
	botWorldPosition isNil ifFalse: [ aStream nextPutAll: 'w-position: ' , botWorldPosition printString ]
]

{ #category : 'private' }
Miner >> randomDirection [
	"a direction is a point composed by -1, 0, or 1 with the constraint
	that x * y should always be = to 0"

	| x y |
	x := 3 atRandom - 2.
	y := 3 atRandom - 2.
	^ (x * y) isZero
		  ifTrue: [ x @ y ]
		  ifFalse: [ self randomDirection ]
]

{ #category : 'private' }
Miner >> rightDirectionEncoding [

	| dir |
	dir := self direction.
	^ dir y negated @ dir x
]

{ #category : 'private' }
Miner >> rightPosition [
	"returns the position of the right tile taking into account the
	direction of the bot"

	^ self rightDirectionEncoding + botWorldPosition
]

{ #category : 'private' }
Miner >> rightTile [
	"returns the right tile that should be in the world"

	^ botWorld firstTileAt: self rightPosition
]

{ #category : 'variables' }
Miner >> set: aSymbol to: anObject [
	"Defines a robot variable named aSymbol and assign anObject as value"

	vars at: aSymbol put: anObject
]

{ #category : 'operations' }
Miner >> south [

	self direction: self southEncoding
]

{ #category : 'private' }
Miner >> southEncoding [

	^ 0 @ 1
]

{ #category : 'turning' }
Miner >> turnLeft [

	self direction: self leftDirectionEncoding
]

{ #category : 'turning' }
Miner >> turnRight [

	self direction: self rightDirectionEncoding
]

{ #category : 'drawing' }
Miner >> updateHead [
	"place the head and the eye in the current direction"

	| extent h h2 headCenter |
	extent := MinerWorld defaultTileSize.
	h := extent y // 3.
	h2 := extent y // 5.
	headCenter := extent / 2 + (direction * h).
	head position: headCenter - (h / 2).
	eye position: headCenter + (direction * 2) - (h2 / 2)
]

{ #category : 'variables' }
Miner >> valueOf: aSymbol [
	"Return the value of the variable named aSymbol"

	^ vars at: aSymbol ifAbsent: [ self error: 'the robot variable ' , aSymbol asString , ' is not defined' ]
]

{ #category : 'operations' }
Miner >> west [

	self direction: self westEncoding
]

{ #category : 'private' }
Miner >> westEncoding [

	^ -1 @ 0
]
