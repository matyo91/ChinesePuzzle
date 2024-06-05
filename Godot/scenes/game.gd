class_name GameScene extends Node2D

var root: RootScene
var bgMusicTheme: int
var board: Dictionary

func _init():
	for i in range(8):
		board[i] = {}
		for j in range(14):
			board[i][j] = null

func _ready() -> void:
	bgMusicTheme = root.data.BackgroundMusicThemes.ThemeNone
	
	root.user.load()
	
	var initBoard = root.user.getInitBoard()
	if(initBoard.size() == 0):
		randInitBoard()
	
	loadBoard()
	
	layout()

func randInitBoard():
	var deck = []
	
	for k in range(1, 3):
		for color in root.data.CardPlayColor:
			for rank in root.data.CardPlayRank:
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
	pass

func newGame() -> void:
	root.soundManager.play('shuffle')
	
func retryGame() -> void:
	root.soundManager.play('shuffle')

func layout():
	pass
