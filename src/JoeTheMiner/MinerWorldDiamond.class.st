Class {
	#name : 'MinerWorldDiamond',
	#superclass : 'MinerWorldTile',
	#category : 'JoeTheMiner-World',
	#package : 'JoeTheMiner',
	#tag : 'World'
}

{ #category : 'description' }
MinerWorldDiamond class >> description [

	^ $D
]

{ #category : 'initialization' }
MinerWorldDiamond >> initializeColor [
	"a diamond is transparent and only shows a shiny gem in its middle"

	| gem side |
	side := MinerWorld defaultTileSize x - 10.
	gem := BlElement new
		       extent: side @ side;
		       position: 5 @ 5;
		       geometry: (BlPolygonGeometry vertices: {
						        (side / 2 @ 0).
						        (side @ (side / 2)).
						        (side / 2 @ side).
						        (0 @ (side / 2)) });
		       background: (BlRadialGradientPaint new
				        stops: {
						        (0 -> Color white).
						        (1 -> (Color gray: 0.25)) };
				        center: side / 2 @ (side / 2);
				        radius: side / 2;
				        yourself);
		       preventMouseEvents;
		       yourself.
	self addChild: gem
]

{ #category : 'initialization' }
MinerWorldDiamond >> initializeStyle [
	"diamonds stay above the tile they lie on"

	super initializeStyle.
	self zIndex: 1
]

{ #category : 'testing' }
MinerWorldDiamond >> isDiamondTile [

	^ true
]
