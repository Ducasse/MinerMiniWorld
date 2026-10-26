"
I am a code editor to drive the miners of a board. I am a Spec presenter opened with the Toplo backend (Spec-Toplo), so I am rendered with Bloc and Toplo. Each miner is bound to its name, so you can evaluate for example:

b1 turnLeft; go; go.
[ b1 canMoveForward ] whileTrue: [ b1 go ]

Do it evaluates the selection, or all the text when nothing is selected; Print it also shows the result. Errors raised by the miners are shown in my status line.
"
Class {
	#name : 'MinerController',
	#superclass : 'SpPresenter',
	#instVars : [
		'botWorldBoard',
		'code',
		'status'
	],
	#category : 'JoeTheMiner-Board',
	#package : 'JoeTheMiner',
	#tag : 'Board'
}

{ #category : 'application' }
MinerController class >> application [
	"Spec application rendering with Toplo"

	^ SpApplication new
		  useBackend: #Toplo;
		  yourself
]

{ #category : 'instance creation' }
MinerController class >> on: aMinerWorldBoard [

	^ self newApplication: self application model: aMinerWorldBoard
]

{ #category : 'opening' }
MinerController >> close [

	self withWindowDo: [ :aWindow | aWindow close ]
]

{ #category : 'accessing' }
MinerController >> code [

	^ code
]

{ #category : 'layout' }
MinerController >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  spacing: 4;
		  add: (SpBoxLayout newLeftToRight
				   spacing: 8;
				   add: (self newButton
						    label: 'Do it';
						    action: [ self doIt ];
						    yourself)
				   expand: false;
				   add: (self newButton
						    label: 'Print it';
						    action: [ self printIt ];
						    yourself)
				   expand: false;
				   yourself)
		  expand: false;
		  add: code;
		  add: status expand: false;
		  yourself
]

{ #category : 'evaluating' }
MinerController >> doIt [

	self evaluatePrinting: false
]

{ #category : 'evaluating' }
MinerController >> evaluatePrinting: aBoolean [
	"Evaluate outside of the Bloc pulse process so that the miners can be seen moving"

	| source bindings |
	source := self sourceToEvaluate.
	source isAllSeparators ifTrue: [ ^ self ].
	bindings := botWorldBoard botBindings.
	self showStatus: 'Running...'.
	[
		[
			| result |
			result := OpalCompiler new
				          bindings: bindings;
				          evaluate: source.
			self showStatus: (aBoolean
					 ifTrue: [ result printString ]
					 ifFalse: [ 'Done' ]) ]
			on: Error
			do: [ :error | self showStatus: 'Error: ' , error messageText ] ]
		forkAt: Processor userSchedulingPriority
		named: 'Miner controller'
]

{ #category : 'initialization' }
MinerController >> initializePresenters [

	code := self newCode.
	code text: ''.
	status := self newLabel.
	status label: 'Each miner is known by its name, e.g. b1 go'
]

{ #category : 'initialization' }
MinerController >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Miner Controller';
		initialExtent: 420 @ 260;
		whenClosedDo: [ botWorldBoard removeController: self ]
]

{ #category : 'evaluating' }
MinerController >> printIt [

	self evaluatePrinting: true
]

{ #category : 'initialization' }
MinerController >> setModelBeforeInitialization: aMinerWorldBoard [

	botWorldBoard := aMinerWorldBoard
]

{ #category : 'evaluating' }
MinerController >> showStatus: aString [
	"can be called from any process, the label is updated by the UI"

	self application defer: [ status label: aString ]
]

{ #category : 'evaluating' }
MinerController >> sourceToEvaluate [
	"the selection, or all the text when nothing is selected"

	| selection |
	selection := code selectedText.
	^ (selection isEmptyOrNil
		   ifTrue: [ code text ]
		   ifFalse: [ selection ]) asString
]

{ #category : 'accessing' }
MinerController >> statusText [

	^ status label asString
]
