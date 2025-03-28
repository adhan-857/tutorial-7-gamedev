extends CharacterBody3D

@export var speed: float = 10.0
@export var acceleration: float = 5.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.3
@export var sprint_multiplier: float = 2.0
@export var crouch_multiplier: float = 0.5
@export var double_tap_time: float = 0.3

var camera_x_rotation: float = 0.0
var last_tap_time: float = 0.0 
var is_sprinting: bool = false
var is_crouching: bool = false

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation

func _physics_process(delta):
	var movement_vector = Vector3.ZERO
	var current_speed = speed

	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x

	movement_vector = movement_vector.normalized()

	if Input.is_action_just_pressed("movement_forward"):
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - last_tap_time < double_tap_time:
			is_sprinting = true
		last_tap_time = current_time

	if not Input.is_action_pressed("movement_forward"):
		is_sprinting = false

	if Input.is_key_pressed(KEY_SHIFT):
		is_crouching = true
	else:
		is_crouching = false

	if is_sprinting:
		current_speed *= sprint_multiplier
	elif is_crouching:
		current_speed *= crouch_multiplier

	velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	move_and_slide()
