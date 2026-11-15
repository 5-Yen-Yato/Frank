extends Node2D
var direction: Vector2 = Vector2.ZERO
const SPEED: int = 220

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
