extends Node3D

@onready var pause_menu = $Menu
@onready var health_bar = $CanvasLayer
var paused = false
var fireball_scene: PackedScene = preload("res://Scenes/vfx/fireball.tscn")

func _on_player_cast_spell(type: String, pos: Vector3, direcrion: Vector2, size: float) -> void:
	var fireball = fireball_scene.instantiate()
	$Projectiles.add_child(fireball)
	fireball.global_position = pos
	fireball.direction = direcrion

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		health_bar.hide()
		Engine.time_scale = 0
	
	paused = !paused
