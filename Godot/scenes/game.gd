class_name GameScene extends Node2D

var root: RootScene
var board: Board
var menu: Menu
var bgMusicTheme: Data.BackgroundMusicThemes

func _init():
	bgMusicTheme = Data.BackgroundMusicThemes.ThemeNone

func _ready() -> void:
	root.user.load()
	
	play_background_music(root.user.get_is_sound_on())
	
	get_board()
	#var initBoard = root.user.getInitBoard()
	#if(initBoard.size() == 0):
	#	randInitBoard()
	
	#loadBoard()
	
	#layout()
	
	#var sprite = Sprite2D.new()
	#root.data.load_theme_sprite(sprite, 'chinese', true, 'card_H8.png')
	#add_child(sprite)
	var card = Card.new_with_root_and_color_and_rank(root, Card.CardColor.Spade, Card.CardRank.Ace)
	card.layout()
	card.position = Vector2(100, 100)

func get_board() -> Board:
	if menu:
		remove_child(menu)
		menu = null
	
	if board == null:
		board = Board.new_with_root(root)
		add_child(board)
	
	return board

func get_menu() -> Menu:
	return get_menu_with_layout(Menu.LayoutType.None)
	
func get_menu_with_layout(layout: Menu.LayoutType) -> Menu:
	if menu == null:
		menu = Menu.new_with_root(root)
		add_child(menu)

	return menu

func new_game() -> void:
	root.soundManager.play('shuffle')

func retry_game() -> void:
	root.soundManager.play('shuffle')

func play_background_music(play: bool):
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
