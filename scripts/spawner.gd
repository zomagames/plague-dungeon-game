extends Node

const ENEMY_SCENE = preload("res://scenes/enemy.tscn")
const SPAWN_RADIUS = 400.0
const INITIAL_SPAWN_RATE = 2.0  # Enemies per second

var spawn_timer = 0.0
var current_spawn_rate = INITIAL_SPAWN_RATE
var player: Node2D
var enemy_container: Node
var difficulty_multiplier = 1.0

func _ready():
	player = get_tree().get_first_node_in_group("player")
	enemy_container = get_parent().get_node("EnemyContainer")

func _physics_process(delta):
	if not player:
		return
	
	spawn_timer -= delta
	
	if spawn_timer <= 0:
		spawn_enemy()
		spawn_timer = 1.0 / current_spawn_rate

func spawn_enemy():
	"""Spawn an enemy near the player"""
	var enemy = ENEMY_SCENE.instantiate()
	enemy_container.add_child(enemy)
	
	# Spawn at random position around player
	var spawn_angle = randf() * TAU
	var spawn_pos = player.global_position + Vector2(cos(spawn_angle), sin(spawn_angle)) * SPAWN_RADIUS
	enemy.global_position = spawn_pos
	
	# Apply difficulty scaling
	enemy.speed *= difficulty_multiplier
	enemy.health = int(enemy.health * difficulty_multiplier)
	
	print("[Spawner] Enemy spawned at: ", spawn_pos)

func increase_difficulty():
	"""Increase difficulty for new wave"""
	difficulty_multiplier += 0.1
	current_spawn_rate += 0.5
	print("[Spawner] Difficulty increased! Multiplier: %.1f" % difficulty_multiplier)
