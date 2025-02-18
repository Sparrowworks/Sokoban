extends Node

var master_volume: float = 100.0
var music_volume: float = 100.0
var sfx_volume: float = 100.0

var level: int = 1

func go_to_with_fade(scene: String) -> void:
	var transition: Node = Composer.setup_load_screen("res://src/Composer/LoadingScreens/Fade/FadeScreen.tscn")

	if transition:
		#button_click.play()
		await transition.finished_fade_in
		Composer.load_scene(scene)
