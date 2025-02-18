class_name Level extends Node2D

signal level_completed()

var boxes: Dictionary = {}

func _ready() -> void:
	for box: Box in get_tree().get_nodes_in_group("Boxes"):
		boxes[box] = false
		box.box_updated.connect(_on_box_updated)

	for coin: Coin in get_tree().get_nodes_in_group("Coins"):
		coin.coin_collected.connect(_on_coin_collected)

func _on_coin_collected() -> void:
	print("SCORE")

func _on_box_updated(box: Box, is_secured: bool) -> void:
	boxes[box] = is_secured
	print(boxes)
