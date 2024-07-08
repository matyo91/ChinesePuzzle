class_name GameScene extends Node2D

var root: RootScene
var bgMusicTheme: int
var board: Dictionary
var cards: Array[Card]
var boardCards: Array[BoardCard]

func _init():
	bgMusicTheme = root.data.BackgroundMusicThemes.ThemeNone
	root.user.load()
	
	board = {}
	for i in range(8):
		for j in range(14):
			var coord = Vector2(i, j)
			board[coord] = null
	cards = []
	boardCards = []

func _ready() -> void:
	
	var initBoard = root.user.getInitBoard()
	if(initBoard.size() == 0):
		randInitBoard()
	
	loadBoard()
	
	layout()
	
	var sprite = root.data.getThemeSprite('chinese', true, 'card_H8.png')
	add_child(sprite)
	sprite.position = Vector2(100, 100)

func newGame() -> void:
	root.soundManager.play('shuffle')

func retryGame() -> void:
	root.soundManager.play('shuffle')

func randInitBoard():
	var deck = []
	
	for k in range(1, 3):
		for color in Card.CardColor:
			for rank in Card.CardRank:
				deck.push_back({
					"color": color,
					"rank": rank
				})
		
	deck.shuffle()
	
	var initBoard = root.user.getInitBoard()
	initBoard.clear()
	
	var k = 0
	for i in range(8):
		for j in range(1, 14):
			var coord = Vector2(i, j)
			initBoard[coord] = deck[k]
			k += 1

func loadBoard():
	for move in root.user.getMoves():
		var switch = board[move.to]
		board[move.to] = board[move.from]
		board[move.from] = switch

func layout():
	var BoardCardScene = preload("res://entities/board_card.tscn")
	if boardCards.size() == 0:
		for i in range(8):
			for j in range(14):
				var boardCard = BoardCardScene.instantiate()
				add_child(boardCard)
				boardCards.append(boardCard)
	
	var newCards = []
	
	for coord in board:
		var i = 0
