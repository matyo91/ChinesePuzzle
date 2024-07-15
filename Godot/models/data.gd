class_name Data extends Object

enum BackgroundMusicThemes {
	ThemeNone = 0,
	Theme1 = 1,
	Theme2 = 2,
	Theme3 = 3,
}

func get_themes() -> Array[String]:
	return [
		'chinese',
		'circle',
		'classic',
		'polkadots',
		'seamless',
		'shullshearts',
		'splash',
		'spring',
		'stripes',
		'vivid',
	]

func parse_plist_dict(node: XMLNode) -> Dictionary:
	var data = {}

	var key = ''
	for child in node.children:
		if(child.name == 'key'):
			key = child.content
		elif(child.name == 'dict'):
			data[key] = parse_plist_dict(child)
		else:
			data[key] = child.content

	return data

func get_texture_rect(plistPath: String, frame: String) -> Rect2:
	var data = parse_plist_dict(XML.parse_file(plistPath).root.children[0])
	var parts = data['frames'][frame]['frame'].lstrip("{{").rstrip("}}").split("},{")

	var pos = parts[0].split(",")
	var size = parts[1].split(",")
	var x = int(pos[0])
	var y = int(pos[1])
	var width = int(size[0])
	var height = int(size[1])
	
	return Rect2(Vector2(x, y), Vector2(width, height))

func load_sprite(sprite: Sprite2D, theme: String, is_card_layout: bool, mode: String, file: String) -> Sprite2D:
	var path = 'res://datas/images/' + ('themes/' + theme if mode == 'theme' else 'ui')
	var plistPath = path + '.plist'
	var texturePath = path + '.png'
	
	var sprites = {}
	if mode == 'ui':
		sprites['menuMask.png'] = [{
			'from': 'menuMask.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuContainer.png'] = [{
			'from': 'menuContainer.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemYes.png'] = [{
			'from': 'menuItemYes.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemNo.png'] = [{
			'from': 'menuItemNo.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemOk.png'] = [{
			'from': 'menuItemOk.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeClassic.png'] = [{
			'from': 'menuItemThemeClassic.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeChinese.png'] = [{
			'from': 'menuItemThemeChinese.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeCircle.png'] = [{
			'from': 'menuItemThemeCircle.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemePolkadots.png'] = [{
			'from': 'menuItemThemePolkadots.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeSeamless.png'] = [{
			'from': 'menuItemThemeSeamless.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeSkullshearts.png'] = [{
			'from': 'menuItemThemeSkullshearts.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeSplash.png'] = [{
			'from': 'menuItemThemeSplash.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeSpring.png'] = [{
			'from': 'menuItemThemeSpring.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeStripes.png'] = [{
			'from': 'menuItemThemeStripes.png',
			'to': Vector2(0, 0),
		}]
		sprites['menuItemThemeVivid.png'] = [{
			'from': 'menuItemThemeVivid.png',
			'to': Vector2(0, 0),
		}]
	elif mode == 'theme':
		sprites['bg.png'] = [{
			'from': 'bg.png',
			'to': Vector2(0, 0),
		}]
		sprites['cardplaybg.png'] = [{
			'from': 'cardplaybg.png',
			'to': Vector2(0, 0),
		}]
		sprites['cardboardempty.png'] = [{
			'from': 'cardboardempty.png',
			'to': Vector2(0, 0),
		}]
		sprites['cardboardyes.png'] = [{
			'from': 'cardboardyes.png',
			'to': Vector2(0, 0),
		}]
		sprites['cardboardno.png'] = [{
			'from': 'cardboardno.png',
			'to': Vector2(0, 0),
		}]
		sprites['cardtouched.png'] = [{
			'from': 'cardtouched.png',
			'to': Vector2(0, 0),
		}]
		sprites['newBtn.png'] = [{
			'from': 'newBtn.png',
			'to': Vector2(0, 0),
		}]
		sprites['retryBtn.png'] = [{
			'from': 'retryBtn.png',
			'to': Vector2(0, 0),
		}]
		sprites['hintBtn.png'] = [{
			'from': 'hintBtn.png',
			'to': Vector2(0, 0),
		}]
		sprites['soundOnBtn.png'] = [{
			'from': 'soundOnBtn.png',
			'to': Vector2(0, 0),
		}]
		sprites['soundOffBtn.png'] = [{
			'from': 'soundOffBtn.png',
			'to': Vector2(0, 0),
		}]
		sprites['themeBtn.png'] = [{
			'from': 'themeBtn.png',
			'to': Vector2(0, 0),
		}]
		sprites['undoBtn.png'] = [{
			'from': 'undoBtn.png',
			'to': Vector2(0, 0),
		}]
		
		var card_bg_texture_rect = get_texture_rect(plistPath, 'cardbg.png')
		var center_position = card_bg_texture_rect.size / 2
		
		var colors = ['D', 'S', 'H', 'C']
		var ranks = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']

		for color in colors:
			for rank in ranks:
				if is_card_layout and rank == "A":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "2":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "3":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "4":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "5":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "6":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "7":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "8":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 1.5 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 2.5 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
				elif is_card_layout and rank == "9":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 4 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 4 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 1.5 * card_bg_texture_rect.size.y / 5) - center_position,
					}]
				elif is_card_layout and rank == "10":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 4 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 2 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 4 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 1.5 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, 3.5 * card_bg_texture_rect.size.y / 5) - center_position,
					}]
				elif is_card_layout and (rank == "J" or rank == "Q" or rank == "K"):
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 2) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 2) - center_position,
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 4 * card_bg_texture_rect.size.y / 5) - center_position,
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 5) - center_position,
					}]
				else:
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'big_' + color + '.png',
						'to': Vector2(2 * card_bg_texture_rect.size.x / 4, card_bg_texture_rect.size.y / 4) - center_position,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * card_bg_texture_rect.size.x / 4, 3 * card_bg_texture_rect.size.y / 4) - center_position,
					}]
		
	var texture = load(texturePath)
	
	for index in range(sprites[file].size()):
		var zone = sprites[file][index]
		var child = sprite if index == 0 else Sprite2D.new()
		child.texture = texture
		child.region_rect = get_texture_rect(plistPath, zone['from'])
		child.region_enabled = true
		child.position = zone.to
		
		if index > 0:
			sprite.add_child(child)
	
	return sprite

func load_ui_sprite(sprite: Sprite2D, is_card_layout: bool, file: String) -> Sprite2D:
	return load_sprite(sprite, '', is_card_layout, 'ui', file)

func load_theme_sprite(sprite: Sprite2D, theme: String, is_card_layout: bool, file: String) -> Sprite2D:
	return load_sprite(sprite, theme, is_card_layout, 'theme', file)
