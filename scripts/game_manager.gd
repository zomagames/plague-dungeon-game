extends Node

# Game state
var score = 0
var current_level = 1
var current_wave = 1
var enemies_killed = 0
var time_elapsed = 0.0
var is_paused = false
var is_game_over = false

# References
var player: Node2D
var spawner: Node
var ui: Control
var enemy_container: Node
var particle_effects: Node2D

func _ready():
	# Get references to other game components
	player = get_node("Player")
	spawner = get_node("EnemySpawner")
	enemy_container = get_node("EnemyContainer")
	ui = get_node("UILayer/UI")
	
	# Create particle effect system
	particle_effects = Node2D.new()
	particle_effects.script = load("res://scripts/particle_effects.gd")
	add_child(particle_effects)
	
	# Add to group so enemy/spawner can find it
	add_to_group("game_manager")
	
	# Connect signals
	if player.has_signal("died"):
		player.died.connect(_on_player_died)
	
	if player.has_signal("health_changed"):
		player.health_changed.connect(_on_player_health_changed)
	
	print("[GameManager] Game started!")
	print("[GameManager] Sprites loaded from res://sprites/")

func _process(delta):
	if is_paused or is_game_over:
		return
	
	time_elapsed += delta
	
	# Check for pause input
	if Input.is_action_just_pressed("ui_cancel"):
		pause_game()
	
	# Update UI
	if ui:
		ui.update_score(score)
		ui.update_wave(current_wave)
		ui.update_level(current_level)

func add_score(points: int):
	"""Add points to the player's score"""
	score += points
	print("[GameManager] Score: %d" % score)

func on_enemy_killed():
	"""Called when an enemy is killed"""
	enemies_killed += 1
	add_score(10)  # Base score per kill
	
	# Spawn kill effect
	if particle_effects and player:
		particle_effects.spawn_kill_effect(player.global_position + Vector2(randf_range(-50, 50), randf_range(-50, 50)))
	
	# Check for level progression (every 15 kills, increase level)
	if enemies_killed % 15 == 0:
		level_up()

func level_up():
	"""Player levels up"""
	current_level += 1
	current_wave += 1
	
	# Spawn level-up effect
	if particle_effects and player:
		particle_effects.spawn_level_up_effect(player.global_position)
	
	# Upgrade weapon
	var weapon = player.get_node("Weapon")
	if weapon:
		weapon.upgrade_damage(5)
		weapon.upgrade_fire_rate(0.05)
	
	# Increase spawner difficulty
	spawner.increase_difficulty()
	
	print("[GameManager] LEVEL UP! Level: %d" % current_level)

func pause_game():
	"""Pause the game"""
	is_paused = true
	get_tree().paused = true
	print("[GameManager] Game paused")

func resume_game():
	"""Resume the game"""
	is_paused = false
	get_tree().paused = false
	print("[GameManager] Game resumed")

func _on_player_died():
	"""Called when player dies"""
	is_game_over = true
	print("[GameManager] Game Over! Final Score: %d, Level: %d" % [score, current_level])
	if ui:
		ui.show_game_over(score)

func _on_player_health_changed(new_health: int):
	"""Update health display"""
	if ui:
		ui.update_health(new_health, player.max_health)

func get_game_state() -> Dictionary:
	"""Return current game state"""
	return {
		"score": score,
		"level": current_level,
		"wave": current_wave,
		"time": time_elapsed,
		"enemies_killed": enemies_killed
	}
