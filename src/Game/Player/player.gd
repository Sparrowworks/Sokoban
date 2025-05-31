class_name Player extends AnimatedSprite2D

signal move_count_updated(move_count: int, push_count: int)

@onready var wall_ray: RayCast2D = $WallRay

const TILE_SIZE: int = 64

var move_tween: Tween

var moves: Array = []
var past_moves: Array = []

var move_enabled: bool = true

var move_count: int = 0
var push_count: int = 0

func _process(delta: float) -> void:
	if not move_enabled:
		return

	# Each button press adds a move to the list in the order the keys are pressed.
	# At the end of _process, the first move from the list will be executed.

	if Input.is_action_just_pressed("up"):
		moves.append("up")

	if Input.is_action_just_pressed("down"):
		moves.append("down")

	if Input.is_action_just_pressed("left"):
		moves.append("left")

	if Input.is_action_just_pressed("right"):
		moves.append("right")

	if Input.is_action_just_pressed("back"):
		execute_past_move()

	if moves.size() > 0 and move_tween == null:
		move(moves.pop_front()) # Executes the first move from the list

func can_move(direction: Vector2) -> bool:
	# If we hit a box, check if we can push it, else we stop movement
	if wall_ray.is_colliding():
		var collider: Node = wall_ray.get_collider() as Node
		if collider.is_in_group("Boxes"):
			var box: Box = collider as Box
			if box.move(direction):
				push_count += 1
				move_count_updated.emit(move_count, push_count)
				add_move_to_past_moves(direction, box)
				return true
			else:
				return false
		else:
			return false

	add_move_to_past_moves(direction)
	return true

func get_direction(move: String) -> Vector2:
	match move:
		"up":
			return Vector2.UP
		"down":
			return Vector2.DOWN
		"left":
			return Vector2.LEFT
		"right":
			return Vector2.RIGHT
		_:
			return Vector2.ZERO

func add_move_to_past_moves(direction: Vector2, box: Box = null) -> void:
	# Adds the last move to the list of past moves. If a box was pushed, insert it after the move direction at the front of the list.
	if direction == Vector2.UP:
		past_moves.append("down")
	elif direction == Vector2.DOWN:
		past_moves.append("up")
	elif direction == Vector2.LEFT:
		past_moves.append("right")
	elif direction == Vector2.RIGHT:
		past_moves.append("left")

	if box:
		past_moves.append(box)

func move(move: String, skip_check: bool = false) -> void:
	var direction: Vector2 = get_direction(move)

	play(move + "_walk")
	wall_ray.target_position = Vector2(TILE_SIZE/2, TILE_SIZE/2) * direction
	wall_ray.force_raycast_update()

	# skip_check is for movements that are being undone and thus we dont have to check if we can move in that direction
	if not skip_check:
		if not can_move(direction):
			play(move + "_idle")
			return

	$WalkSound.play()
	if not skip_check:
		move_count += 1

	move_count_updated.emit(move_count, push_count)

	var new_pos: Vector2 = Vector2(self.global_position.x + (TILE_SIZE * direction.x), self.global_position.y + (TILE_SIZE * direction.y))
	move_tween = get_tree().create_tween()
	move_tween.tween_property(self, "global_position", new_pos, 0.2)
	move_tween.tween_callback(
		func() -> void:
			play(move + "_idle")
			move_tween.kill()
			move_tween = null
	)

func execute_past_move() -> void:
	if past_moves.size() < 1 or move_tween != null:
		return

	var move: Variant = past_moves.pop_back()
	var box: Box

	# If the last move is a string, it represents a player movement that needs to be undone.
	if typeof(move) == TYPE_STRING:
		move(move, true)
	else: # If the type of the last move is a box, this means we have to push back the box and the player based on the direction which is behind the box in the list.
		box = move as Box
		move = past_moves.pop_back()
		box.move(get_direction(move), true)
		move(move, true)

		push_count -= 1

	move_count -= 1
	move_count_updated.emit(move_count, push_count)

func _on_coin_detector_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coins"):
		var coin: Coin = area as Coin
		$CoinSound.play()
		coin.collect()

func _on_level_level_completed() -> void:
	move_enabled = false
