extends CharacterBody3D

@export var jump_height : float = 2.25
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.3

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var base_speed = 12.0
@export var run_speed = 16.0

@export var max_health = 100
@export var current_health = 100

@onready var health_bar = get_node("/root/world/CanvasLayer/HUD/HealthBar")

@onready var camera = $CameraController/Camera3D

var movement_input := Vector2.ZERO
var last_movement_input := Vector2(0,1)

signal cast_spell(type: String, pos: Vector3, direcrion: Vector2, size: float)

func _ready():
	health_bar.max_value = max_health
	health_bar.value = current_health

func _physics_process(delta: float) -> void:
	move_logic(delta)
	jump_logic(delta)
	move_and_slide()	
	ability_logic()
	hit()
	
func move_logic(delta) -> void:
	movement_input = Input.get_vector("Left", "Right", "Forward", "Back").rotated(-camera.global_rotation.y)
	var vel_2d = Vector2(velocity.x, velocity.z)
	var is_running: bool = Input.is_action_pressed("Run")
	
	if movement_input != Vector2.ZERO:
		var speed = run_speed if is_running else base_speed
		vel_2d += movement_input * speed * delta
		vel_2d = vel_2d.limit_length(speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y	
		$einar.set_move_state('running')
		var target_angle = -movement_input.angle() + PI/2
		$einar.rotation.y = target_angle
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed * 4.0 * delta)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y	
		$einar.set_move_state('idle')
		
	if movement_input:
		last_movement_input = movement_input
	
func jump_logic(delta) -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("Jump"):
			velocity.y = -jump_velocity
	var gravity = jump_gravity if velocity.y > 0.0 else fall_gravity
	velocity.y -= gravity * delta
	
func ability_logic() -> void:
		if Input.is_action_just_pressed("Attack"):
			$einar.attack()

func hit():
	$einar.hit()

func take_damage(amount: int):
	current_health -= amount
	print(current_health)
	health_bar.value = current_health
	if current_health <= 0:
		die()
	
func die():
	print("Player died!")
	queue_free()

func shoot_fireball(pos: Vector3) -> void:
	cast_spell.emit("fireball", pos, last_movement_input, 1.0)
