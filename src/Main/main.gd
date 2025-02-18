class_name Main extends Control

func _ready() -> void:
	Composer.root = self
	Composer.load_scene("res://src/MainMenu/MainMenu.tscn")
