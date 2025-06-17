extends Control

@onready var title: Label = $Text/Title
@onready var text: Label = $Text/Text
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var page_switch: Tween
var is_switching: bool = false
var page: int = 0

var headings: Array[String] = [
	"Credits:",
	"Controls:",
]
var content: Array[String] = [
	"""Developed by sparrowworks:
	programmer - sp4r0w
	tester - vargadot
	assets:
	hyper casual ui by MadFireOn
	sokoban asset pack - kenney
	Ultimate UI SFX Pack by JDSherbert
	Casual Game Vol 2 by Zakiro
	Free Game Menu Music Pack by VOiD1 Gaming""",

	"""WASD or Arrow keys - move the character
	R - reset the level
	Q - undo a move"""
]

func _ready() -> void:
	title.text = headings[page]
	text.text = content[page]

func _on_page_button_pressed() -> void:
	if is_switching:
		return

	is_switching = true
	page = (page + 1) % content.size()

	animation_player.play("FadeIn")
	await animation_player.animation_finished

	title.text = headings[page]
	text.text = content[page]

	animation_player.play("FadeOut")
	await animation_player.animation_finished

	is_switching = false

func _on_back_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/MainMenu/MainMenu.tscn")
