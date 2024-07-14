class_name User extends Object

var theme: String
var isCardLayout: bool
var isSoundOn: bool
var moves: Array[Move]
var initBoard: Dictionary

func _init():
	theme = default_theme()
	isCardLayout = false
	isSoundOn = false
	moves = []
	initBoard = {}

func default_theme() -> String:
	return 'chinese'

func get_theme() -> String:
	return theme

func set_theme(_theme: String):
	theme = _theme

func get_is_card_layout() -> bool:
	return isCardLayout

func set_is_card_layout(_isCardLayout: bool):
	isCardLayout = _isCardLayout
	
func get_is_sound_on() -> bool:
	return isSoundOn;

func set_is_sound_on(_isSoundOn: bool):
	isSoundOn = _isSoundOn

func get_moves() -> Array[Move]:
	return moves

func clear_moves():
	moves = []
	
func push_move(_move: Move):
	moves.append(_move)

func pop_move():
	moves.pop_back()
	
func get_init_board() -> Dictionary:
	return initBoard

func load() -> Dictionary:
	if not FileAccess.file_exists("user://chinesepuzzle.save"):
		return {'success': false}
	
	var save_game = FileAccess.open("user://chinesepuzzle.save", FileAccess.READ)
	var json = JSON.new()
	var parse_result = json.parse(save_game.get_as_text())
	save_game.close()
	
	if not parse_result == OK:
		return {'success': false}
	var json_data = json.get_data()
	
	theme = json_data['user']['theme']
	isCardLayout = json_data['user']['isCardLayout']
	isSoundOn = json_data['user']['isSoundOn']
	
	return {
		'success': true,
		'savedate': json_data['savedate'],
	}

func save():
	var save_game = FileAccess.open("user://chinesepuzzle.save", FileAccess.WRITE)
	
	var json_string = JSON.stringify({
		'savedate': Time.get_date_dict_from_system(),
		'user': {
			'theme': theme,
			'isCardLayout': isCardLayout,
			'isSoundOn': isSoundOn,
		}
	})
	
	save_game.store_string(json_string)
	save_game.close()
