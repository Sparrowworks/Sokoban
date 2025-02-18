@tool
class_name SecureZone extends Area2D

signal box_secured(box: Box)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export_range(1,5) var box_type: int = 1:
	set(val):
		box_type = val
		if animated_sprite_2d != null:
			animated_sprite_2d.play(str(box_type))

func _ready() -> void:
	animated_sprite_2d.play(str(box_type))
