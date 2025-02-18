class_name Game extends Control

@onready var game_panel: TextureRect = $GamePanel
@onready var end_panel: TextureRect = $EndPanel

@onready var level_text: Label = %LevelText
@onready var score_text: Label = %ScoreText
@onready var time_text: Label = %TimeText
@onready var move_text: Label = %MoveText
@onready var push_text: Label = %PushText
@onready var time_timer: Timer = $TimeTimer
@onready var end_time_text: Label = %EndTimeText
@onready var end_score_text: Label = %EndScoreText
@onready var end_move_text: Label = %EndMoveText
@onready var end_push_text: Label = %EndPushText
@onready var play_button: TextureButton = %PlayButton

var time: int = 0
var score: int = 0
var moves: int = 0
var pushes: int = 0

var level: Level

func _ready() -> void:
	level_text.text = "Level: " + str(Globals.level)

	load_level()
	time_timer.start()

func load_level() -> void:
	var path: String = "res://src/Game/Level/Levels/Level" + str(Globals.level) + ".tscn"
	var level_scene: PackedScene = load(path)
	level = level_scene.instantiate()
	add_child(level)

	level.level_completed.connect(_on_level_completed)
	level.score_updated.connect(_on_score_updated)
	level.player.move_count_updated.connect(_on_move_count_updated)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		Globals.go_to_with_fade("res://src/Game/Game.tscn")

func _on_score_updated(value: int) -> void:
	score += value
	score_text.text = "Score: " + str(score)

func _on_move_count_updated(move_count: int, push_count: int) -> void:
	moves = move_count
	pushes = push_count

	move_text.text = "Moves: " + str(moves)
	push_text.text = "Pushes: " + str(pushes)

func _on_menu_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/MainMenu/MainMenu.tscn")

func _on_time_timer_timeout() -> void:
	time += 1
	time_text.text = "Time: " + str(time)

func _on_level_completed() -> void:
	time_timer.stop()

	await get_tree().create_timer(1).timeout
	game_panel.hide()
	level.hide()

	end_time_text.text = "Time: " + str(time)
	end_score_text.text = "Score: " + str(score)
	end_move_text.text = "Moves: " + str(moves)
	end_push_text.text = "Pushes: " + str(pushes)

	if Globals.level == 24:
		play_button.hide()

	end_panel.show()


func _on_play_button_pressed() -> void:
	Globals.level += 1
	Globals.go_to_with_fade("res://src/Game/Game.tscn")
