class_name Data extends Object

enum BackgroundMusicThemes {
	ThemeNone = 0,
	Theme1 = 1,
	Theme2 = 2,
	Theme3 = 3,
}

func getThemes() -> Array[String]:
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

func parsePlistDict(node: XMLNode) -> Dictionary:
	var data = {}

	var key = ''
	for child in node.children:
		if(child.name == 'key'):
			key = child.content
		elif(child.name == 'dict'):
			data[key] = parsePlistDict(child)
		else:
			data[key] = child.content

	return data

func getTextureRect(plistPath: String, frame: String) -> Rect2:
	var data = parsePlistDict(XML.parse_file(plistPath).root.children[0])
	var parts = data['frames'][frame]['frame'].lstrip("{{").rstrip("}}").split("},{")

	var pos = parts[0].split(",")
	var size = parts[1].split(",")
	var x = int(pos[0])
	var y = int(pos[1])
	var width = int(size[0])
	var height = int(size[1])
	
	return Rect2(Vector2(x, y), Vector2(width, height))

func getSprite(theme: String, isCardLayout: bool, mode: String, file: String) -> Sprite2D:
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
		
		var cardBGTextureRect = getTextureRect(plistPath, 'cardbg.png')
		var centerPosition = cardBGTextureRect.size / 2
		
		var colors = ['D', 'S', 'H', 'C']
		var ranks = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']

		for color in colors:
			for rank in ranks:
				if isCardLayout and rank == "A":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "2":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "3":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "4":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "5":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "6":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "7":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "8":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 1.5 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 2.5 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
				elif isCardLayout and rank == "9":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 4 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 4 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 1.5 * cardBGTextureRect.size.y / 5) - centerPosition,
					}]
				elif isCardLayout and rank == "10":
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 4 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 2 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 4 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 1.5 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, 3.5 * cardBGTextureRect.size.y / 5) - centerPosition,
					}]
				elif isCardLayout and (rank == "J" or rank == "Q" or rank == "K"):
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 2) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 2) - centerPosition,
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 4 * cardBGTextureRect.size.y / 5) - centerPosition,
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 5) - centerPosition,
					}]
				else:
					sprites['card_' + color + rank + '.png'] = [{
						'from': 'cardbg.png',
						'to': Vector2(0, 0)
					}, {
						'from': 'rank_' + color + rank + '.png',
						'to': Vector2(cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'big_' + color + '.png',
						'to': Vector2(2 * cardBGTextureRect.size.x / 4, cardBGTextureRect.size.y / 4) - centerPosition,
					}, {
						'from': 'small_' + color + '.png',
						'to': Vector2(3 * cardBGTextureRect.size.x / 4, 3 * cardBGTextureRect.size.y / 4) - centerPosition,
					}]
		
	var texture = load(texturePath)
	
	var sprite = Sprite2D.new()
	
	for index in range(sprites[file].size()):
		var zone = sprites[file][index]
		var child = sprite if index == 0 else Sprite2D.new()
		child.texture = texture
		child.region_rect = getTextureRect(plistPath, zone['from'])
		child.region_enabled = true
		child.position = zone.to
		
		if index > 0:
			sprite.add_child(child)
	
	return sprite

func getUiSprite(isCardLayout: bool, file: String) -> Sprite2D:
	return getSprite('', isCardLayout, 'ui', file)

func getThemeSprite(theme: String, isCardLayout: bool, file: String) -> Sprite2D:
	return getSprite(theme, isCardLayout, 'theme', file)
