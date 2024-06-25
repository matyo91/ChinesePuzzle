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
		sprites['menuMask'] = 'auto'
		sprites['menuContainer'] = 'auto'
		sprites['menuItemYes'] = 'auto'
		sprites['menuItemNo'] = 'auto'
		sprites['menuItemOk'] = 'auto'
		sprites['menuItemThemeClassic'] = 'auto'
		sprites['menuItemThemeChinese'] = 'auto'
		sprites['menuItemThemeCircle'] = 'auto'
		sprites['menuItemThemePolkadots'] = 'auto'
		sprites['menuItemThemeSeamless'] = 'auto'
		sprites['menuItemThemeSkullshearts'] = 'auto'
		sprites['menuItemThemeSplash'] = 'auto'
		sprites['menuItemThemeSpring'] = 'auto'
		sprites['menuItemThemeStripes'] = 'auto'
		sprites['menuItemThemeVivid'] = 'auto'
	elif mode == 'theme':
		sprites['bg'] = 'auto'
		sprites['cardplaybg'] = 'auto'
		sprites['cardboardempty'] = 'auto'
		sprites['cardboardyes'] = 'auto'
		sprites['cardboardno'] = 'auto'
		sprites['cardtouched'] = 'auto'
		sprites['newBtn'] = 'auto'
		sprites['retryBtn'] = 'auto'
		sprites['hintBtn'] = 'auto'
		sprites['soundOnBtn'] = 'auto'
		sprites['soundOffBtn'] = 'auto'
		sprites['themeBtn'] = 'auto'
		sprites['undoBtn'] = 'auto'
	
	var sprite = Sprite2D.new()
	sprite.texture = load(texturePath)
	sprite.region_rect = getTextureRect(plistPath, file)
	sprite.region_enabled = true
	
	return sprite

func getUiSprite(isCardLayout: bool, file: String) -> Sprite2D:
	return getSprite('', isCardLayout, 'ui', file)

func getThemeSprite(theme: String, isCardLayout: bool, file: String) -> Sprite2D:
	return getSprite(theme, isCardLayout, 'theme', file)
