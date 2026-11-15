extends StaticBody2D

@onready var bullet_timer: Timer = $BulletTimer
const BULLETGROUP = preload("res://scenes/outer_bullets.tscn")
const BULLET = preload("res://scenes/bullet.tscn")
@onready var player: Node2D = get_tree().get_first_node_in_group("Player")
var bullet_counter: int = 50
var variation = randi_range(0, 1)
@onready var audio = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet_timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	

func _on_bullet_timer_timeout() -> void:
	if bullet_counter == 50:
		bullet_timer.paused = true
		audio.play()
		await get_tree().create_timer(1.5).timeout
		bullet_timer.paused = false
		if variation == 0:
			variation = 1
		else:
			variation = 0
		bullet_counter = 0
	if variation == 0:
		bullet_timer.start(0.25)
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		var dir = (player.global_position - global_position).normalized()
		bullet_instance.direction = dir
		bullet_counter += 1
	if variation == 1:
		bullet_timer.start(1.25)
		var bullet_instance = BULLETGROUP.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = global_position
		var dir = (player.global_position - global_position).normalized()
		bullet_instance.direction = dir
		bullet_counter += 5
