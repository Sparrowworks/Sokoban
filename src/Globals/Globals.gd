extends Node

var master_volume: float = 100.0
var music_volume: float = 100.0
var sfx_volume: float = 100.0

var level: int = 1

var menu_theme: AudioStreamPlayer
var game_theme: AudioStreamPlayer
var button_click: AudioStreamPlayer


func play_menu_theme() -> void:
	if not menu_theme.playing:
		menu_theme.play()


func setup_game_theme() -> void:
	game_theme.stream = load("res://assets/audio/Game/track" + str(randi_range(1, 5)) + ".mp3")
	game_theme.play()


func go_to_with_fade(scene: String) -> void:
	var transition: Node = Composer.setup_load_screen(
		"res://src/Composer/LoadingScreens/Fade/FadeScreen.tscn"
	)

	if transition:
		button_click.play()
		await transition.finished_fade_in
		Composer.load_scene(scene)
