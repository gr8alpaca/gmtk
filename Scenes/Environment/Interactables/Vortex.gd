@tool
class_name Vortex extends Area2D

const RADIUS_TO_POINT_UNIT_DISTANCE_RATIO: float = 0.6
@export var radius: float = 64.0:
    set(val):
        radius = val
        gravity_point_unit_distance = radius * RADIUS_TO_POINT_UNIT_DISTANCE_RATIO


@export var spin_speed: float = 1.0

@export var sprite: Sprite2D:
    set(val):
        sprite = val

@export var rein_color: Color:
    set(val):
        rein_color = val
        queue_redraw()

@export var rein_width: float = 2.0:
    set(val):
        rein_width = val
        queue_redraw()

var player: Player


func _init() -> void:
    gravity_space_override = SPACE_OVERRIDE_COMBINE
    gravity_point = true
    gravity_point_center = Vector2.ZERO


func _enter_tree() -> void:
    if get_parent() is Player:
        player = get_parent()


func _draw() -> void:
    if not sprite: return
    var player_delta: Vector2 = player.global_position - global_position if player is Player else Vector2(128, 0)
    const PLAYER_Y_OFFSET: Vector2 = Vector2(0, 16)

    draw_multiline([Vector2(0, radius), player_delta + PLAYER_Y_OFFSET, -Vector2(0, radius), player_delta - PLAYER_Y_OFFSET], rein_color, rein_width)


func _physics_process(delta: float) -> void:
    for body: RigidBody2D in get_overlapping_bodies():
        var body_position: Vector2 = global_position - body.global_position

        body.apply_force(body_position)


func _process(delta: float) -> void:
    if sprite: sprite.rotation += fmod(spin_speed * delta, TAU)
