class_name Data extends Object

enum BackgroundMusicThemes {
	ThemeNone = 0,
	Theme1 = 1,
	Theme2 = 2,
	Theme3 = 3,
}

enum CardPlayColor {
	Spade = 1,
	Club = 2,
	Heart = 3,
	Diamond = 4,
}

enum CardPlayRank {
	Ace = 1,
	Two = 2,
	Three = 3,
	Four = 4,
	Five = 5,
	Six = 6,
	Seven = 7,
	Eight = 8,
	Nine = 9,
	Ten = 10,
	Jack = 11,
	Queen = 12,
	King = 13,
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
