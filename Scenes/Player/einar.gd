extends Node3D

@onready var move_state_machine = $AnimationTree.get("parameters/MoveStateMachine/playback")

var attacking := false

func set_move_state(state_name: String) -> void:
	move_state_machine.travel(state_name)

func attack() -> void:
	$AnimationTree.set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func shoot_fireball() -> void:
	get_parent().shoot_fireball($rig_001/Skeleton3D/BoneAttachment3D/staff/Marker3D.global_position)

func attack_toggle(value: bool):
	attacking = value

func hit() -> void:
	attacking = false
