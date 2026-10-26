"
I am a small Spec dialog, opened with the Toplo backend, asking for a text or just informing.

MinerRequest request: 'Name?' initialAnswer: 'b2' do: [ :aString | ... ].
MinerRequest inform: 'Done'.

(SpRequestDialog cannot be used yet with Spec-Toplo: it sends #takeKeyboardFocus that SpToploTextInputFieldAdapter does not implement.)
"
Class {
	#name : 'MinerRequest',
	#superclass : 'SpPresenter',
	#instVars : [
		'answer',
		'label',
		'input',
		'acceptBlock'
	],
	#category : 'JoeTheMiner-Board',
	#package : 'JoeTheMiner',
	#tag : 'Board'
}

{ #category : 'instance creation' }
MinerRequest class >> inform: aString [

	^ (self newApplication: MinerController application model: nil)
		  message: aString;
		  open;
		  yourself
]

{ #category : 'instance creation' }
MinerRequest class >> request: aString initialAnswer: anAnswer do: aBlock [
	"aBlock receives the accepted text"

	^ (self newApplication: MinerController application model: anAnswer)
		  message: aString;
		  acceptBlock: aBlock;
		  open;
		  yourself
]

{ #category : 'actions' }
MinerRequest >> accept [

	| text |
	text := input ifNotNil: [ input text asString trimBoth ].
	self close.
	acceptBlock ifNotNil: [ acceptBlock value: text ]
]

{ #category : 'accessing' }
MinerRequest >> acceptBlock: aBlock [

	acceptBlock := aBlock
]

{ #category : 'actions' }
MinerRequest >> close [

	self withWindowDo: [ :aWindow | aWindow close ]
]

{ #category : 'layout' }
MinerRequest >> defaultLayout [

	| buttons box |
	buttons := SpBoxLayout newLeftToRight
		           spacing: 8;
		           add: (self newButton
				            label: 'OK';
				            action: [ self accept ];
				            yourself)
		           expand: false;
		           yourself.
	input ifNotNil: [
			buttons
				add: (self newButton
						 label: 'Cancel';
						 action: [ self close ];
						 yourself)
				expand: false ].
	box := SpBoxLayout newTopToBottom
		       spacing: 8;
		       add: label expand: false;
		       yourself.
	input ifNotNil: [ box add: input expand: false ].
	^ box
		  add: buttons expand: false;
		  yourself
]

{ #category : 'initialization' }
MinerRequest >> initializePresenters [

	label := self newLabel.
	answer ifNotNil: [
			input := self newTextInput.
			input text: answer.
			input whenSubmitDo: [ :text | self accept ] ]
]

{ #category : 'initialization' }
MinerRequest >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Joe the Miner';
		initialExtent: 340 @ 150
]

{ #category : 'accessing' }
MinerRequest >> input [

	^ input
]

{ #category : 'accessing' }
MinerRequest >> message: aString [

	label label: aString
]

{ #category : 'initialization' }
MinerRequest >> setModelBeforeInitialization: aString [
	"with an answer I ask for a text, without I just inform"

	answer := aString
]
