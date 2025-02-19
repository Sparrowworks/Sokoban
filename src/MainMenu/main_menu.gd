extends Control

func _ready() -> void:
	Globals.play_menu_theme()

func _on_play_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/LevelSelect/LevelSelect.tscn")

func _on_settings_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/Settings/Settings.tscn")

func _on_help_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/Help/Help.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
