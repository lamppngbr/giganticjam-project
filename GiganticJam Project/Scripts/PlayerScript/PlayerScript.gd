extends KinematicBody

# Definindo as variáveis de movimentação
var velocity := Vector3()
var direction : Vector3 = Vector3()
var speed = WALK_SPEED
const WALK_SPEED := 18.0
const RUN_SPEED := WALK_SPEED * 2.0
var acelleration := 10

# Definindo as variáveis de gravidade e pulo
var gravity := 10.0
const JUMP_FORCE := 10.0

# Definindo as variáveis da Camera
var mouse_sensibility := 0.1
onready var head : Spatial = $Head

func _process(delta):
	if Input.is_action_just_pressed("ui_quit_game"):
		get_tree().quit()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	OS.window_fullscreen = true

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensibility))
		head.rotate_x(deg2rad(event.relative.y * -mouse_sensibility))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	direction.y -= gravity * delta
	
	mov_player(delta)

func mov_player(delta) -> void:
	var body_rotation = global_transform.basis.get_euler().y
	direction = Vector3(Input.get_axis("mov_left", "mov_right"), 0, Input.get_axis("mov_foward", "mov_backward").rotated(Vector3.UP, body_rotation))
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acelleration * delta)
	
	move_and_slide(velocity, Vector3.UP)


