class_name GameScene extends Node2D

var root: RootScene
var board: Board
var menu: Menu
var bgMusicTheme: int

func _init():
	bgMusicTheme = root.data.BackgroundMusicThemes.ThemeNone

func _ready() -> void:
	root.user.load()
	
	getBoard()
	#var initBoard = root.user.getInitBoard()
	#if(initBoard.size() == 0):
	#	randInitBoard()
	
	#loadBoard()
	
	#layout()
	
	var sprite = root.data.getThemeSprite('chinese', true, 'card_H8.png')
	add_child(sprite)
	sprite.position = Vector2(100, 100)

func getBoard() -> Board:
	if menu:
		remove_child(menu)
		menu = null
	
	if board == null:
		board = Board.new()
		add_child(board)
	
	return board

func getMenu() -> Menu:
	return getMenuWithLayout(Menu.LayoutType.None)
	
func getMenuWithLayout(layout: Menu.LayoutType) -> Menu:
	if menu == null:
		menu = Menu.new()
		add_child(menu)

	return menu

func newGame() -> void:
	root.soundManager.play('shuffle')

func retryGame() -> void:
	root.soundManager.play('shuffle')

