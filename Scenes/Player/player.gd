class_name Player extends CharacterBody2D

const MOUSE_DISTANCE_THRESHOLD: float = 2.0

@export var speed: float = 300.0
@export var turning_speed: float = 1.0
@export var camera_move_speed: float = 100.0
@export var max_cam_offset: float = 25.0
@export var cam: Camera2D


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		velocity = Vector2.ZERO
		return

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos: Vector2 = get_local_mouse_position()
		var global_mouse_dir: Vector2 = global_position.direction_to(get_global_mouse_position())
		var mouse_distance: float = mouse_pos.length()
		var destination_position: Vector2 = mouse_pos.normalized() * speed if mouse_distance > MOUSE_DISTANCE_THRESHOLD else Vector2.ZERO

		rotation = rotate_toward(rotation, global_mouse_dir.angle(), turning_speed * delta)

		velocity = velocity.move_toward(global_mouse_dir * speed, delta * speed * minf(mouse_distance / MOUSE_DISTANCE_THRESHOLD, 1.0))
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * speed)


	move_and_slide()


func _process(delta: float) -> void:
	if not cam: return
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		cam.position = cam.position.move_toward(get_local_mouse_position(), camera_move_speed * delta)
	else:
		cam.position = cam.position.move_toward(Vector2.ZERO, camera_move_speed * delta)