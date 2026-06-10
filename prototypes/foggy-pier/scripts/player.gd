extends CharacterBody2D
## The player: a lantern-carrying figure that drifts around the pier.
##
## Movement uses smooth acceleration/friction so it feels like walking on a
## creaking dock rather than snapping instantly. Supports both arrow keys
## (via Godot's built-in ui_* actions) and WASD (via physical keys, so it
## works regardless of keyboard layout) with no project input map needed.

## Top movement speed in pixels/second.
@export var speed: float = 130.0
## How quickly the figure gets up to speed.
@export var acceleration: float = 1000.0
## How quickly the figure slows to a stop when no key is held.
@export var friction: float = 1400.0

@onready var lantern: PointLight2D = $Lantern

# State used to gently sway the lantern light as you walk.
var _sway_time: float = 0.0
var _base_light_energy: float = 1.0


func _ready() -> void:
	if lantern:
		_base_light_energy = lantern.energy


func _physics_process(delta: float) -> void:
	var dir := _read_input()

	if dir != Vector2.ZERO:
		velocity = velocity.move_toward(dir * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
	_animate_lantern(delta)


## Collects movement intent from arrows + WASD into a normalized direction.
func _read_input() -> Vector2:
	var dir := Vector2.ZERO

	# Arrow keys via Godot's always-present UI actions.
	dir.x = Input.get_axis("ui_left", "ui_right")
	dir.y = Input.get_axis("ui_up", "ui_down")

	# WASD via physical keycodes (layout-independent, no input map required).
	if Input.is_physical_key_pressed(KEY_A):
		dir.x -= 1.0
	if Input.is_physical_key_pressed(KEY_D):
		dir.x += 1.0
	if Input.is_physical_key_pressed(KEY_W):
		dir.y -= 1.0
	if Input.is_physical_key_pressed(KEY_S):
		dir.y += 1.0

	# limit_length keeps diagonal movement from being faster than straight.
	return dir.limit_length(1.0)


## Adds a faint flicker + sway so the lantern feels alive, stronger while moving.
func _animate_lantern(delta: float) -> void:
	if not lantern:
		return
	_sway_time += delta * (4.0 + velocity.length() * 0.03)
	var flicker := sin(_sway_time * 3.1) * 0.05 + sin(_sway_time * 7.7) * 0.03
	lantern.energy = _base_light_energy + flicker
