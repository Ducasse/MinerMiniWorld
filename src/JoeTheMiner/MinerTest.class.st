Class {
	#name : 'MinerTest',
	#superclass : 'TestCase',
	#instVars : [
		'world',
		'bot'
	],
	#category : 'JoeTheMiner-Tests',
	#package : 'JoeTheMiner',
	#tag : 'Tests'
}

{ #category : 'running' }
MinerTest >> setUp [

	super setUp.
	world := MinerWorld new installAreaNamed: #oneForTest.
	bot := Miner new.
	world addMiner: bot
]

{ #category : 'tests' }
MinerTest >> testCanMove [

	self deny: bot canMoveForward.
	self assert: bot canMoveLeft.
	self assert: bot canMoveRight
]

{ #category : 'tests' }
MinerTest >> testCanMove2 [

	bot turnLeft.
	self assert: bot canMoveForward.
	self assert: bot canMoveLeft.
	self deny: bot canMoveRight
]

{ #category : 'tests' }
MinerTest >> testCanMove3 [

	bot turnRight.
	self assert: bot canMoveForward.
	self deny: bot canMoveLeft.
	self assert: bot canMoveRight
]

{ #category : 'tests' }
MinerTest >> testDiamondOnRed [

	self assert: bot isOnRed.
	self assert: bot isAtHome.
	bot loadDiams: 4.
	bot drop.
	self assert: bot isOnRed.
	self assert: bot isAtHome
]

{ #category : 'tests' }
MinerTest >> testDropDiamond [

	self assert: bot diamNumber equals: 0.
	bot loadDiams: 1.
	self assert: bot diamNumber equals: 1.
	self assert: bot canDrop.
	bot drop.
	self deny: bot canDrop.
	self should: [ bot drop ] raise: Error
]

{ #category : 'tests' }
MinerTest >> testGreenPainted [

	self deny: bot isOnGreen.
	self assert: bot isAtHome.
	bot south.
	bot go.
	self deny: bot isOnRed.
	bot paintYellow.
	self assert: bot isOnYellow
]

{ #category : 'tests' }
MinerTest >> testIsOnBlue [

	bot south.
	bot go.
	self assert: bot isOnBlue
]

{ #category : 'tests' }
MinerTest >> testIsOnGreen [

	self deny: bot isOnGreen.
	self assert: bot isAtHome.
	bot loadDiams: 4.
	bot west.
	bot go.
	self deny: bot isOnRed.
	self assert: bot isOnGreen.
	bot drop.
	self assert: bot isOnGreen
]

{ #category : 'tests' }
MinerTest >> testIsWallOnLeft [

	self deny: bot isWallOnLeft.
	self deny: bot isWallOnRight
]

{ #category : 'tests' }
MinerTest >> testIsWallOnLeft2 [

	bot turnLeft.
	self deny: bot isWallOnLeft.
	self assert: bot isWallOnRight
]

{ #category : 'tests' }
MinerTest >> testIsWallOnLeft3 [

	bot turnRight.
	self assert: bot isWallOnLeft.
	self deny: bot isWallOnRight
]

{ #category : 'tests' }
MinerTest >> testLeftTilePosition [

	self assert: bot leftPosition equals: 9 @ 11.
	bot turnRight.
	self assert: bot leftPosition equals: 10 @ 10
]

{ #category : 'tests' }
MinerTest >> testLevelDescriptionRoundTrip [
	"new in the Bloc version: saving the current level gives back its description"

	self
		assert: (world currentLevelDescription reject: [ :each | each isSeparator ])
		equals: (MinerWorld oneForTest reject: [ :each | each isSeparator ])
]

{ #category : 'tests' }
MinerTest >> testPaintRedImpossible [

	self assert: bot isOnRed.
	self assert: bot isAtHome.
	bot paintYellow.
	self assert: bot isOnRed.
	self assert: bot isAtHome
]

{ #category : 'tests' }
MinerTest >> testPickDiamond [
	"new in the Bloc version: the miner picks a diamond and the diamond leaves the world"

	| diamondCount |
	bot loadDiams: 1.
	bot drop.
	diamondCount := world children count: [ :each | each isKindOf: MinerWorldDiamond ].
	self assert: bot canPick.
	bot pick.
	self assert: bot diamNumber equals: 1.
	self deny: bot canPick.
	self assert: (world children count: [ :each | each isKindOf: MinerWorldDiamond ]) equals: diamondCount - 1.
	self should: [ bot pick ] raise: Error
]

{ #category : 'tests' }
MinerTest >> testRightTilePosition [

	self assert: bot rightPosition equals: 11 @ 11.
	bot turnLeft.
	self assert: bot rightPosition equals: 10 @ 10
]

{ #category : 'tests' }
MinerTest >> testTurnRightLeft [

	| dir |
	dir := bot direction.
	bot turnRight.
	bot turnLeft.
	self assert: bot direction equals: dir.
	4 timesRepeat: [ bot turnRight ].
	self assert: bot direction equals: dir
]

{ #category : 'tests' }
MinerTest >> testVar [

	bot set: #count to: 0.
	self assert: (bot valueOf: #count) isZero.
	self shouldnt: [ bot valueOf: #count ] raise: Error.
	bot set: #count to: (bot valueOf: #count) + 1.
	self assert: (bot valueOf: #count) equals: 1.
	bot set: #newCount to: 3.
	bot set: #count to: (bot valueOf: #count) + (bot valueOf: #newCount).
	self assert: (bot valueOf: #count) equals: 4.
	self should: [ bot valueOf: #lulu ] raise: Error.
	self assert: (bot isVariableDefined: #count).
	self deny: (bot isVariableDefined: #lulu)
]
