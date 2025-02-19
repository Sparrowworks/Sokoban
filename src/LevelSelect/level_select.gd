extends Control

func _on_level_button_level_selected(level: int) -> void:
	Globals.menu_theme.stop()
	Globals.level = level
	Globals.go_to_with_fade("res://src/Game/Game.tscn")

func _on_back_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/MainMenu/MainMenu.tscn")
