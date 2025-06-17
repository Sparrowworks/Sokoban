@tool
class_name LevelButton extends TextureButton

signal level_selected(level: int)

@onready var level_text: Label = $LevelText

@export var level_id: int = 1:
	set(val):
		level_id = val
		if level_text != null:
			level_text.text = str(level_id)


func _ready() -> void:
	level_text.text = str(level_id)


func _on_pressed() -> void:
	level_selected.emit(level_id)
