class_name CardPlay extends Node2D

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

var color: CardPlayColor
var rank: CardPlayRank
