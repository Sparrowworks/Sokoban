extends Control


func _on_level_button_level_selected(level: int) -> void:
	Globals.level = level

func _on_back_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/MainMenu/MainMenu.tscn")
