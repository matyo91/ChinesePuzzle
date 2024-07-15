class_name Card extends Sprite2D

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
var is_locked: bool = false
var is_face_up: bool = false

static func new_with_root(_root: RootScene) -> Card:
	var card = Card.new()
	card.root = _root
	
	return card

static func new_with_root_and_color_and_rank(_root: RootScene, _color: CardColor, _rank: CardRank) -> Card:
	var card = Card.new_with_root(_root)
	card.set_color(_color)
	card.set_rank(_rank)
	
	return card

func get_color() -> CardColor:
	return color

func set_color(_color: CardColor) -> Card:
	color = _color
	return self

func get_rank() -> CardRank:
	return rank

func set_rank(_rank: CardRank) -> Card:
	rank = _rank
	return self

func get_is_locked() -> bool:
	return is_locked

func set_is_locked(_is_locked: bool) -> Card:
	is_locked = _is_locked
	return self

func get_is_face_up() -> bool:
	return is_locked

func set_is_face_up(_is_face_up: bool) -> Card:
	is_face_up = _is_face_up
	return self

func layout():
	pass
