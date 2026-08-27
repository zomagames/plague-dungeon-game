extends CharacterBody2D

const BASE_SPEED = 150.0
const BASE_HEALTH = 10
const BASE_DAMAGE = 5

@export var speed = BASE_SPEED
@export var health = BASE_HEALTH
@export var damage = BASE_DAMAGE

var current_health: int
var player: Node2D
var game_manager: Node
var damage_cooldown = 0.0
var damage_cooldown_max = 1.0  # Can damage player every 1 second

signal died(enemy)

func _ready():
	current_health = health
	player = get_tree().get_first_node_in_group("player")
	game_manager = get_tree().get_first_node_in_group("game_manager")
	
	# Add to enemy group for collision detection
	add_to_group("enemies")

func _physics_process(delta):
	damage_cooldown -= delta
	
	if not player:
		return
	
	# Chase player
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	
	move_and_slide()
	
	# Check for collision with player
	var overlapping_areas = get_overlapping_areas()
	for area in overlapping_areas:
		if area.is_in_group("player") and damage_cooldown <= 0:
			player.take_damage(damage)
			damage_cooldown = damage_cooldown_max

func take_damage(damage_amount: int):
	"""Take damage from projectiles"""
	current_health -= damage_amount
	
	if current_health <= 0:
		die()

func die():
	"""Enemy died"""
	if game_manager:
		game_manager.on_enemy_killed()
	
	died.emit(self)
	queue_free()

func get_position() -> Vector2:
	"""Return position for collision"""
	return global_position
