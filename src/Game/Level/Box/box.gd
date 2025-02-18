@tool
class_name Box extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray: RayCast2D = $WallRay

@export_range(1,5) var box_type: int = 1:
	set(val):
		box_type = val
		if animated_sprite_2d != null:
			animated_sprite_2d.play(str(box_type))

func _ready() -> void:
	animated_sprite_2d.play(str(box_type))

func can_move(direction: Vector2) -> bool:
	wall_ray.target_position = Vector2(32,32) * direction
	wall_ray.force_raycast_update()

	if wall_ray.is_colliding():
		var collider: Node = wall_ray.get_collider() as Node
		if collider.is_in_group("Coins") or collider.is_in_group("SecureZones"):
			return true
		else:
			return false

	return true
