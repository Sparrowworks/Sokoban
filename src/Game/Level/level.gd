class_name Level extends Node2D

signal level_completed()

var boxes: Dictionary = {}

func _ready() -> void:
	for box: Box in get_tree().get_nodes_in_group("Boxes"):
		pass

	for coin: Coin in get_tree().get_nodes_in_group("Coins"):
		pass
