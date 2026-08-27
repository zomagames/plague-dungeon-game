extends Control

@onready var score_label = $ScoreLabel
@onready var wave_label = $WaveLabel

var health_label: Label
var level_label: Label

func _ready():
	print("[UI] UI initialized")
	
	# Create additional UI labels if they don't exist
	if not has_node("HealthLabel"):
		health_label = Label.new()
		health_label.name = "HealthLabel"
		add_child(health_label)
		health_label.anchor_left = 0.0
		health_label.anchor_top = 0.1
		health_label.anchor_right = 0.2
		health_label.anchor_bottom = 0.2
		health_label.text = "Health: 100/100"
	else:
		health_label = $HealthLabel
	
	if not has_node("LevelLabel"):
		level_label = Label.new()
		level_label.name = "LevelLabel"
		add_child(level_label)
		level_label.anchor_left = 0.8
		level_label.anchor_top = 0.1
		level_label.anchor_right = 1.0
		level_label.anchor_bottom = 0.2
		level_label.text = "Level: 1"
	else:
		level_label = $LevelLabel

func update_score(new_score: int):
	"""Update score display"""
	if score_label:
		score_label.text = "Score: %d" % new_score

func update_wave(wave: int):
	"""Update wave display"""
	if wave_label:
		wave_label.text = "Wave: %d" % wave

func update_level(level: int):
	"""Update level display"""
	if level_label:
		level_label.text = "Level: %d" % level

func update_health(current: int, max_health: int):
	"""Update health display"""
	if health_label:
		health_label.text = "Health: %d/%d" % [current, max_health]

func show_game_over(final_score: int):
	"""Show game over screen"""
	print("[UI] Game Over! Final Score: %d" % final_score)
	# TODO: Display game over dialog
