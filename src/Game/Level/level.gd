class_name Level extends Node2D

signal level_completed()

var boxes: Dictionary = {}

func _ready() -> void:
	for box: Box in $Boxes.get_children():
		pass
