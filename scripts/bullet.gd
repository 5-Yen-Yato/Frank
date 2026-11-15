extends Node2D

const SPEED: int = 200
var direction: Vector2 = Vector2.ZERO
@onready var player: Node2D = get_tree().get_first_node_in_group("Player")
func _ready() -> void:
	add_to_group("Bullet")
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		queue_free()
		player.take_life()
		
		
