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

func getNodePath(theme, isCardLayout, mode, file, sprite):
	var path = 'res://data/images/' + ('themes/' + theme if mode == 'theme' else 'ui')
	var plistPath = path + '.plist'
	var texturePath = path + '.png'
