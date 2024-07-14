class_name Card extends Node2D

enum CardColor {
	Spade = 1,
	Club = 2,
	Heart = 3,
	Diamond = 4,
}

enum CardRank {
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

var root: RootScene
var color: CardColor
var rank: CardRank
var is_locked: bool

static func new_with_root(a_root: RootScene) -> Card:
	var card = Card.new()
	card.root = a_root
	
	return card

static func new_with_root_and_color_and_rank(a_root: RootScene, a_color: CardColor, a_rank: CardRank) -> Card:
	var card = Card.new()
	card.root = a_root
	card.color = a_color
	card.rank = a_rank
	
	return card

func get_color() -> CardColor:
	return color

func get_rank() -> CardRank:
	return rank

func get_is_locked() -> bool:
	return is_locked

func set_is_locked(_is_locked: bool) -> Card:
	is_locked = _is_locked
	return self
