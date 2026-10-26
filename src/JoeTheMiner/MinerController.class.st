"
I am a workspace to drive the miners of a board. Each miner is bound to its name, so you can evaluate for example:

b1 turnLeft; go; go.
[ b1 canMoveForward ] whileTrue: [ b1 go ]

I replace the Morphic MinerWorkspace and MinerSystemWindow.
"
Class {
	#name : 'MinerController',
	#superclass : 'SpPresenter',
	#instVars : [
		'botWorldBoard',
		'code'
	],
	#category : 'JoeTheMiner-Board',
	#package : 'JoeTheMiner',
	#tag : 'Board'
}

{ #category : 'accessing' }
MinerController >> closeWindow [

	self withWindowDo: [ :aWindow | aWindow close ]
]

{ #category : 'accessing' }
MinerController >> code [

	^ code
]

{ #category : 'layout' }
MinerController >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: code;
		  yourself
]

{ #category : 'initialization' }
MinerController >> initializePresenters [

	code := self newCode.
	code interactionModel: SpCodeScriptingInteractionModel new.
	code text: ''
]

{ #category : 'initialization' }
MinerController >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Miner Controller';
		initialExtent: 389 @ 209;
		whenClosedDo: [ botWorldBoard removeController: self ]
]

{ #category : 'accessing' }
MinerController >> setBindings: aDictionary [
	"each miner is reachable by its name in the code"

	| model |
	model := code interactionModel.
	model removeAllBindings.
	aDictionary keysAndValuesDo: [ :key :value | model addBinding: (WorkspaceVariable key: key value: value) ]
]

{ #category : 'initialization' }
MinerController >> setModelBeforeInitialization: aMinerWorldBoard [

	botWorldBoard := aMinerWorldBoard
]
