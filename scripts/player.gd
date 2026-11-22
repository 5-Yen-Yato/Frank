extends CharacterBody2D


const SPEED = 110.0
var life: int = 3
var up_sprite = preload("res://assets/Images/backwards.png")
var right_sprite = preload("res://assets/Images/sideways.png")
var down_sprite = preload("res://assets/Images/Frank (1).png")
var left_sprite = preload("res://assets/Images/left.png")
var heart = preload("res://assets/Images/HeartContain.png")
var death_one= preload("res://assets/Images/DeathOne.png")
var death_two = preload("res://assets/Images/DeathTwo.png")
var death_three = preload("res://assets/Images/DeathThree.png")
@onready var sprite = $Sprite2D
@onready var heartOne = $Camera2D/Control/HeartOne
@onready var heartTwo = $Camera2D/Control/HeartTwo
@onready var heartThree = $Camera2D/Control/HeartThree
@onready var audio = $AudioStreamPlayer
var can_move = true

func _ready() -> void:
	add_to_group("Player")
	

func _physics_process(delta: float) -> void:
	if not can_move:
		return
	process_movement()
	move_and_slide()

func process_movement() -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if not can_move:
		return
	if direction.x > 0:
		sprite.texture = right_sprite
	elif direction.y < 0:
		sprite.texture = up_sprite
	elif direction.y > 0:
		sprite.texture = down_sprite
	elif direction.x < 0:
		sprite.texture = left_sprite
	velocity = direction * SPEED
	
func take_life():
	life -= 1
	audio.play()
	var game_timer = get_tree().get_first_node_in_group("game_timer") as Timer
	var bullet_timer = get_tree().get_first_node_in_group("bullet_timer") as Timer
	if life == 2:
		heartOne.texture = heart
		get_tree().call_group("Bullet", "queue_free")
		can_move = false
		sprite.texture = death_one
		game_timer.paused = true
		bullet_timer.paused = true
		await get_tree().create_timer(2).timeout
		can_move = true
		sprite.texture = down_sprite
		game_timer.paused = false
		bullet_timer.paused = false
	elif life == 1:
		heartTwo.texture = heart
		get_tree().call_group("Bullet", "queue_free")
		can_move = false
		sprite.texture = death_two
		game_timer.paused = true
		bullet_timer.paused = true
		await get_tree().create_timer(2).timeout
		can_move = true
		sprite.texture = down_sprite
		game_timer.paused = false
		bullet_timer.paused = false
	elif life < 1:
		heartThree.texture = heart
		get_tree().call_group("Bullet", "queue_free")
		can_move = false
		sprite.texture = death_three
		game_timer.paused = true
		bullet_timer.paused = true
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")
