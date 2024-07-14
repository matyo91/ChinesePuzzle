class_name Board extends Node2D

var root: RootScene
var board: Dictionary

static func new_with_root(a_root: RootScene) -> Board:
	var board = Board.new()
	board.root = a_root
	return board

func rand_init_board():
	var deck = []
	
	for k in range(1, 3):
		for color in Card.CardColor.values():
			for rank in Card.CardRank.values():
				deck.push_back({
					"color": color,
					"rank": rank
				})
		
	deck.shuffle()
	
	var init_board = root.user.get_init_board()
	init_board.clear()
	
	var k = 0
	for i in range(8):
		for j in range(1, 14):
			var coord = Vector2(i, j)
			init_board[coord] = deck[k]
			k += 1

func load_board():
	var cardBoards: Array[BoardCard] = []
	var cardPlays: Array[Card] = []

	for i in range(8):
		for j in range(14):
			var coord = Vector2(i, j)
			var card = board[coord]

			if card is Card:
				cardPlays.append(card)
			elif card is BoardCard:
				cardBoards.append(card)

	for i in range(8):
		var card = null
		for c in cardBoards:
			card = c
			cardBoards.erase(c)
			break
		if card == null:
			card = BoardCard.new_with_root(root)

		var coord = Vector2(i, 0)
		board[coord] = card
	
	var init_board = root.user.get_init_board()
	for coord in init_board.keys():
		var data = init_board[coord]

		var card = null
		for c in cardPlays:
			if data.color == c.getColor() and data.rank == c.getRank():
				card = c
				cardPlays.erase(c)
				break
		if card == null:
			card = Card.new_with_root_and_color_and_rank(root, data.color, data.rank)

		card.set_is_locked(false)
		board[coord] = card

	for move in root.user.get_moves():
		var switch = board[move.to]
		board[move.to] = board[move.from]
		board[move.from] = switch

	for i in range(8):
		for j in range(14):
			var coord = Vector2(i, j)
			var card = get_card(coord)

			if card.get_parent() == null:
				add_child(card)
				#card.position = gl.get_position_in_board_point(coord)

func _init():
	board = {}
	for i in range(8):
		for j in range(14):
			var coord = Vector2(i, j)
			board[coord] = null

func _ready() -> void:
	var initBoard = root.user.get_init_board()
	if initBoard.size() == 0:
		rand_init_board()

	load_board()
	
func get_card(coord: Vector2):
	if 0 <= coord.x and coord.x < 8 and 0 <= coord.y and coord.y < 14:
		return board[coord]
	
	return null
