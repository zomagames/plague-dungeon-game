extends CharacterBody2D

const SPEED = 250.0
const MAX_HEALTH = 100
const ACCELERATION = 1500.0

@export var speed = SPEED
@export var max_health = MAX_HEALTH

var current_health: int
var input_direction = Vector2.ZERO

signal health_changed(new_health)
signal died

func _ready():
	current_health = max_health
	add_to_group("player")
	print("[Player] Spawned at position: ", position)

func _physics_process(delta):
	# Get input
	input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Apply movement
	if input_direction != Vector2.ZERO:
		velocity = input_direction.normalized() * speed
	else:
		velocity = velocity.lerp(Vector2.ZERO, delta * 5)
	
	move_and_slide()

func take_damage(damage: int):
	"""Take damage from enemies"""
	current_health -= damage
	health_changed.emit(current_health)
	print("[Player] Hit! Health: %d/%d" % [current_health, max_health])
	
	if current_health <= 0:
		die()

func heal(amount: int):
	"""Heal the player"""
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health)

func die():
	"""Player died"""
	print("[Player] Died!")
	died.emit()
	queue_free()

func get_position() -> Vector2:
	"""Return player position for AI targeting"""
	return global_position
