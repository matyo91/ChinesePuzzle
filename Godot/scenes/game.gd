class_name GameScene extends Node2D

var root: RootScene
var board: Board
var menu: Menu
var bgMusicTheme: Data.BackgroundMusicThemes

func _init():
	bgMusicTheme = Data.BackgroundMusicThemes.ThemeNone

func _ready() -> void:
	root.user.load()
	
	playBackgroundMusic(root.user.getIsSoundOn())
	
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
	var board = getBoard()
	board.newGame()
	
	root.soundManager.play('shuffle')

func retryGame() -> void:
	var board = getBoard()
	board.retryGame()
	
	root.soundManager.play('shuffle')

func playBackgroundMusic(play: bool):
	if play:
		if bgMusicTheme == Data.BackgroundMusicThemes.Theme1:
			root.soundManager.play('bgm2.mp3', true)
			bgMusicTheme = Data.BackgroundMusicThemes.Theme2
		elif bgMusicTheme == Data.BackgroundMusicThemes.Theme2:
			root.soundManager.play('bgm3.mp3', true)
			bgMusicTheme = Data.BackgroundMusicThemes.Theme3
		else:
			root.soundManager.play('bgm1.mp3', true)
			bgMusicTheme = Data.BackgroundMusicThemes.Theme1
	elif bgMusicTheme != Data.BackgroundMusicThemes.ThemeNone:
		root.soundManager.stopSounds(['bgm1.mp3', 'bgm2.mp3', 'bgm3.mp3'])
