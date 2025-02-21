@tool
class_name Box extends Area2D

signal box_updated(box: Box, is_secured: bool)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray: RayCast2D = $WallRay

@export_range(1,5) var box_type: int = 1:
	set(val):
		box_type = val
		if animated_sprite_2d != null:
			animated_sprite_2d.play(str(box_type))

var move_tween: Tween
var secure_zones: Array = []

func _ready() -> void:
	animated_sprite_2d.play(str(box_type))

func can_move(direction: Vector2) -> bool:
	return not wall_ray.is_colliding()

func move(direction: Vector2, skip_check: bool = false) -> bool:
	wall_ray.target_position = Vector2(32,32) * direction
	wall_ray.force_raycast_update()

	if not skip_check:
		if not can_move(direction):
			return false

	var new_pos: Vector2 = Vector2(self.global_position.x + (64 * direction.x), self.global_position.y + (64 * direction.y))
	move_tween = get_tree().create_tween()
	move_tween.tween_property(self, "global_position", new_pos, 0.2)
	move_tween.tween_callback(
		func() -> void:
			move_tween.kill()
	)

	return true


func check_if_secured() -> void:
	if secure_zones.size() == 0:
		modulate = Color.WHITE
		box_updated.emit(self, false)
		return

	for zone: SecureZone in secure_zones:
		if zone.box_type == self.box_type:
			$BoxSecured.play()
			modulate = Color.GREEN
			box_updated.emit(self, true)
			return

	modulate = Color.WHITE
	box_updated.emit(self, false)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("SecureZones"):
		var zone: SecureZone = area as SecureZone
		secure_zones.append(zone)
		check_if_secured()

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("SecureZones"):
		var zone: SecureZone = area as SecureZone
		secure_zones.erase(zone)
		check_if_secured()
