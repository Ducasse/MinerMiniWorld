Class {
	#name : 'MinerWorldGroundTile',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldGroundTile class >> description [

	^ $G
]

{ #category : 'description' }
MinerWorldGroundTile class >> paneable [

	^ false
]

{ #category : 'drag and drop' }
MinerWorldGroundTile >> handlesMouseDown [

	^ false
]

{ #category : 'initialization' }
MinerWorldGroundTile >> initializeColor [

	self color: Color blue lighter borderColor: Color blue muchLighter
]

{ #category : 'testing' }
MinerWorldGroundTile >> isGroundTile [

	^ true
]

{ #category : 'testing' }
MinerWorldGroundTile >> paneable [
	"should not be put in the tile pane editor"

	^ false
]
