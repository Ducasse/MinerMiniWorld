"
I am a tile of a MinerWorld. Each subclass encodes itself with one character (see class side #description) in area descriptions.

In editing mode, tiles can be dragged (this creates a copy) and dropped on the world. Shift-click deletes a tile from the world.
"
Class {
	#name : 'MinerWorldTile',
	#superclass : 'BlElement',
	#instVars : [
		'botWorldPosition',
		'botWorld'
	],
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldTile class >> description [
	"return the character for encoding the tile in area description"

	^ self subclassResponsibility
]

{ #category : 'description' }
MinerWorldTile class >> paneable [

	^ true
]

{ #category : 'operations' }
MinerWorldTile >> botWorld [

	^ botWorld
]

{ #category : 'operations' }
MinerWorldTile >> botWorld: aWorld [

	botWorld := aWorld
]

{ #category : 'operations' }
MinerWorldTile >> botWorldPosition [

	^ botWorldPosition
]

{ #category : 'operations' }
MinerWorldTile >> botWorldPosition: aPoint [

	botWorldPosition := aPoint
]

{ #category : 'operations' }
MinerWorldTile >> canPassOverMe: aMiner [

	^ true
]

{ #category : 'drag and drop' }
MinerWorldTile >> clickEvent: evt [
	"shift-click removes the tile from the world"

	self handlesMouseDown ifFalse: [ ^ self ].
	(botWorld notNil and: [ evt modifiers isShift ]) ifFalse: [ ^ self ].
	evt consume.
	self delete
]

{ #category : 'initialization' }
MinerWorldTile >> color: aColor borderColor: anotherColor [

	self background: aColor.
	self border: (BlBorder paint: anotherColor width: 2)
]

{ #category : 'element' }
MinerWorldTile >> delete [

	self removeFromParent.
	botWorld isNil ifFalse: [ botWorld remove: self at: botWorldPosition x at: botWorldPosition y ]
]

{ #category : 'drag and drop' }
MinerWorldTile >> dragEndEvent: evt [
	"drop at the center of the dragged copy, computed from the event since the copy may not be laid out yet"

	| ghost |
	ghost := self userData at: #dragGhost ifAbsent: [ ^ self ].
	evt consume.
	self userData removeKey: #dragGhost.
	ghost removeFromParent.
	self dropWorld ifNotNil: [ :aWorld |
		aWorld acceptDroppedTile: ghost atGlobal: evt position - (self userData at: #dragOffset) + (MinerWorld defaultTileSize / 2) ]
]

{ #category : 'drag and drop' }
MinerWorldTile >> dragEvent: evt [

	| ghost |
	ghost := self userData at: #dragGhost ifAbsent: [ ^ self ].
	evt consume.
	ghost position: evt position - (self userData at: #dragOffset)
]

{ #category : 'drag and drop' }
MinerWorldTile >> dragStartEvent: evt [
	"drag a copy of the receiver, the receiver stays in place"

	| ghost |
	self handlesMouseDown ifFalse: [ ^ self ].
	self space ifNil: [ ^ self ].
	evt consume.
	ghost := self class new.
	ghost constraintsDo: [ :c | c ignoreByLayout ].
	ghost zIndex: 100.
	ghost opacity: 0.8.
	ghost position: self positionInSpace.
	self space root addChild: ghost.
	self userData at: #dragGhost put: ghost.
	self userData at: #dragOffset put: evt position - self positionInSpace
]

{ #category : 'drag and drop' }
MinerWorldTile >> dropWorld [
	"the world in which a dragged copy of the receiver can be dropped: my world, or the world of my tile pane"

	^ botWorld ifNil: [ self parent ifNotNil: [ :aPane | aPane botWorld ] ]
]

{ #category : 'drag and drop' }
MinerWorldTile >> handlesMouseDown [
	"if there is a world, it should be in editing mode"

	"if there is no world, I'm in a pane"

	^ botWorld isNil or: [ botWorld isEditing ]
]

{ #category : 'initialization' }
MinerWorldTile >> initialize [
	"MinerWorldTile new openInSpace"

	super initialize.
	self extent: MinerWorld defaultTileSize.
	self initializeColor.
	self initializeStyle.
	self initializeEvents
]

{ #category : 'initialization' }
MinerWorldTile >> initializeColor [

	self subclassResponsibility
]

{ #category : 'initialization' }
MinerWorldTile >> initializeEvents [

	self addEventHandlerOn: BlClickEvent do: [ :evt | self clickEvent: evt ].
	self addEventHandlerOn: BlDragStartEvent do: [ :evt | self dragStartEvent: evt ].
	self addEventHandlerOn: BlDragEvent do: [ :evt | self dragEvent: evt ].
	self addEventHandlerOn: BlDragEndEvent do: [ :evt | self dragEndEvent: evt ]
]

{ #category : 'initialization' }
MinerWorldTile >> initializeStyle [

	self geometry: BlRectangleGeometry new
]

{ #category : 'testing' }
MinerWorldTile >> isBlackTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> isBrickTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> isDiamondTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> isGreenTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> isGroundTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> isMagentaTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> isStartingTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> isYellowTile [

	^ false
]

{ #category : 'testing' }
MinerWorldTile >> paneable [

	^ true
]

{ #category : 'printing' }
MinerWorldTile >> printOn: aStream [

	| clsName |
	clsName := self class name.
	aStream nextPutAll: (clsName copyFrom: 'MinerWorld' size + 1 to: clsName size).
	botWorldPosition isNil ifFalse: [ aStream nextPutAll: 'w-position: ' , botWorldPosition printString ]
]
