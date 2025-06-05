extends Enemy

var attacking := false

@export var max_health = 100
@export var current_health = 100
var is_dead := false

func _physics_process(delta: float) -> void:
	move_to_player(delta)
	
func _on_attack_timer_timeout() -> void:
	if position.distance_to(player.position) < 5.0:
		attack_animation() 
		
func set_idle(state_name: String) -> void:
	move_state_machine.travel(state_name)
		
func attack_animation():
	attacking = !attacking
	$AnimationTree.set("parameters/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	$AttackPlayer.play()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(10)

func take_damage(amount: int):
		current_health -= amount
		print("monster", current_health)
		$HitPlayer.play()

		if current_health <= 0:
			die()

func die() -> void:
	is_dead = true
	print("Enemy died!")
	
	await get_tree().create_timer(2.0).timeout
	queue_free()
