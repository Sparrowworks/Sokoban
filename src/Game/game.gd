class_name Game extends Control

var time: int = 0
var score: int = 0
var moves: int = 0
var pushes: int = 0

var level: Level

func _ready() -> void:
	load_level()

func load_level() -> void:
	var path: String = "res://src/Game/Level/Levels/Level" + str(Globals.level) + ".tscn"
	var level_scene: PackedScene = load(path)
	level = level_scene.instantiate()
	add_child(level)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		Globals.go_to_with_fade("res://src/Game/Game.tscn")
