class_name Menu extends Node2D

enum LayoutType {
	None = 0,
	NewGame = 1,
	RetryGame = 2,
	Hint = 3,
	Theme = 4,
}

enum Tag {
	Bg = 0,
	NewTitle = 1,
	NewYes = 2,
	NewNo = 3,
	RetryTitle = 4,
	RetryYes = 5,
	RetryNo = 6,
}

var root: RootScene
