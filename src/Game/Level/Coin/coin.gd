class_name Coin extends Area2D

signal coin_collected()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("Bounce")

func collect() -> void:
	coin_collected.emit()
	queue_free()
