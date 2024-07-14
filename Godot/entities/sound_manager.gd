class_name SoundManager extends Node

var root: RootScene
var sounds: Dictionary = {}

static func new_with_root(aRoot: RootScene) -> SoundManager:
	var sound_manager = SoundManager.new()
	sound_manager.root = aRoot
	
	return sound_manager

func play(sound: String, loop = false):
	var audio_player = AudioStreamPlayer.new()
	var sound_path = root.data.get_sound(sound)
	audio_player.stream = load("res:/" + sound_path)
	add_child(audio_player)
	sounds[sound_path] = audio_player
	if audio_player.is_inside_tree():
		audio_player.stream.loop = loop
		audio_player.play()

func stop_sound(sound: String):
	var sound_path = root.data.get_sound(sound)
	if sounds.has(sound_path):
		remove_child(sounds[sound_path])
		sounds.erase(sound_path)

func stop_sounds():
	for sound in sounds:
		remove_child(sounds[sound])
		sounds.erase(sound)
