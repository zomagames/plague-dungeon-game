extends Node

# Game state
var score = 0
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

func _ready():
	# Get references to other game components
	player = get_node("Player")
	spawner = get_node("EnemySpawner")
	enemy_container = get_node("EnemyContainer")
	ui = get_node("UILayer/UI")
	
	# Add to group so enemy/spawner can find it
	add_to_group("game_manager")
	
	# Connect signals
	if player.has_signal("died"):
		player.died.connect(_on_player_died)
	
	print("[GameManager] Game started!")

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

func add_score(points: int):
	"""Add points to the player's score"""
	score += points
	print("[GameManager] Score: %d" % score)

func on_enemy_killed():
	"""Called when an enemy is killed"""
	enemies_killed += 1
	add_score(10)  # Base score per kill
	
	# Check for wave progression (every 20 kills, increase difficulty)
	if enemies_killed % 20 == 0:
		current_wave += 1
		spawner.increase_difficulty()
		print("[GameManager] Wave %d started!" % current_wave)

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
	print("[GameManager] Game Over! Final Score: %d" % score)

func get_game_state() -> Dictionary:
	"""Return current game state"""
	return {
		"score": score,
		"wave": current_wave,
		"time": time_elapsed,
		"enemies_killed": enemies_killed
	}
