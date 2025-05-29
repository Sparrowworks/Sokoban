class_name Level extends Node2D

signal score_updated(value: int)
signal level_completed()

@onready var player: Player = $Player

var boxes: Dictionary = {}

func _ready() -> void:
	for box: Box in get_tree().get_nodes_in_group("Boxes"):
		boxes[box] = false
		box.box_updated.connect(_on_box_updated)

	for coin: Coin in get_tree().get_nodes_in_group("Coins"):
		coin.coin_collected.connect(_on_coin_collected)

func _on_coin_collected() -> void:
	score_updated.emit(100)

func _on_box_updated(box: Box, is_secured: bool) -> void:
	# Remove the score if a box, that was previously secured is now pushed away from the secure zone
	if boxes[box] != is_secured:
		boxes[box] = is_secured
		if is_secured:
			score_updated.emit(50)
		else:
			score_updated.emit(-50)

	if not boxes.values().has(false):
		level_completed.emit()
