class_name Player extends AnimatedSprite2D

@onready var wall_ray: RayCast2D = $WallRay

var move_tween: Tween

var moves: Array = []
var past_moves: Array = []

var move_enabled: bool = true

func _physics_process(delta: float) -> void:
	if not move_enabled:
		return

	print(moves)

	if Input.is_action_just_pressed("up"):
		moves.append("up")

	if Input.is_action_just_pressed("down"):
		moves.append("down")

	if Input.is_action_just_pressed("left"):
		moves.append("left")

	if Input.is_action_just_pressed("right"):
		moves.append("right")

	if moves.size() > 0 and move_tween == null:
		move()

func can_move(direction: Vector2) -> bool:
	if wall_ray.is_colliding():
		var collider: Node = wall_ray.get_collider() as Node
		if collider.is_in_group("Boxes"):
			var box: Box = collider as Box
			pass
		elif collider.is_in_group("Coins"):
			pass
		elif collider.is_in_group("SecureZones"):
			pass
		else:
			return false

	return true

func move() -> void:
	var move: String = moves.pop_front()
	var direction: Vector2 = Vector2.ZERO

	match move:
		"up":
			direction = Vector2.UP
		"down":
			direction = Vector2.DOWN
		"left":
			direction = Vector2.LEFT
		"right":
			direction = Vector2.RIGHT

	play(move + "_walk")
	wall_ray.target_position = Vector2(32,32) * direction
	wall_ray.force_raycast_update()
	if can_move(direction):
		var new_pos: Vector2 = Vector2(self.global_position.x + (64 * direction.x), self.global_position.y + (64 * direction.y))
		move_tween = get_tree().create_tween()
		move_tween.tween_property(self, "global_position", new_pos, 0.2)
		move_tween.tween_callback(
			func() -> void:
				play(move + "_idle")
				move_tween.kill()
				move_tween = null
		)
