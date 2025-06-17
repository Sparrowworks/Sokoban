extends Control

@onready var master_text: Label = %MasterText
@onready var master_slider: HSlider = %MasterSlider
@onready var music_text: Label = %MusicText
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_text: Label = %SfxText
@onready var sfx_slider: HSlider = %SfxSlider

const MASTER_IDX: int = 0
const MUSIC_IDX: int = 1
const SFX_IDX: int = 2


func _ready() -> void:
	update_master()
	update_music()
	update_sfx()


func update_master() -> void:
	master_text.text = "Master Volume: " + str(Globals.master_volume)
	master_slider.value = Globals.master_volume
	AudioServer.set_bus_volume_db(MASTER_IDX, linear_to_db(Globals.master_volume / 100))


func update_music() -> void:
	music_text.text = "Music Volume: " + str(Globals.music_volume)
	music_slider.value = Globals.music_volume
	AudioServer.set_bus_volume_db(MUSIC_IDX, linear_to_db(Globals.music_volume / 100))


func update_sfx() -> void:
	sfx_text.text = "SFX Volume: " + str(Globals.sfx_volume)
	sfx_slider.value = Globals.sfx_volume
	AudioServer.set_bus_volume_db(SFX_IDX, linear_to_db(Globals.sfx_volume / 100))


func _on_master_slider_value_changed(value: float) -> void:
	Globals.master_volume = value
	update_master()


func _on_music_slider_value_changed(value: float) -> void:
	Globals.music_volume = value
	update_music()


func _on_sfx_slider_value_changed(value: float) -> void:
	Globals.sfx_volume = value
	update_sfx()


func _on_back_button_pressed() -> void:
	Globals.go_to_with_fade("res://src/MainMenu/MainMenu.tscn")
