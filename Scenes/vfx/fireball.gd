extends Area3D

var direction: Vector2
const speed = 5.0

func _process(delta: float) -> void:
	position += Vector3(direction.x, 0, direction.y) * speed * delta


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Monster"):
		if body.has_method("hit"):
			body.take_damage(20)
			queue_free()

func _on_timer_timeout() -> void:
	queue_free()
