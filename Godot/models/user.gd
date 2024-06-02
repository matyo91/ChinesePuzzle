class_name User extends Object

var theme: String
var isCardLayout: bool
var isSoundOn: bool
var moves: Array
var initBoard: Dictionary

func _init():
	theme = defaultTheme()
	isCardLayout = false
	isSoundOn = false
	moves = []
	initBoard = {}
	
	pass

func defaultTheme() -> String:
	return 'chinese'

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
		}
	})
	
	save_game.store_string(json_string)
	save_game.close()
