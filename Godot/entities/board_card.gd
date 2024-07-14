class_name BoardCard extends Node2D

var root: RootScene

static func new_with_root(a_root: RootScene) -> BoardCard:
	var board_card = BoardCard.new()
	board_card.root = a_root
	
	return board_card
