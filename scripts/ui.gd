extends Control

@onready var score_label = $ScoreLabel
@onready var wave_label = $WaveLabel

func _ready():
	print("[UI] UI initialized")

func update_score(new_score: int):
	"""Update score display"""
	if score_label:
		score_label.text = "Score: %d" % new_score

func update_wave(wave: int):
	"""Update wave display"""
	if wave_label:
		wave_label.text = "Wave: %d" % wave

func show_game_over(final_score: int):
	"""Show game over screen"""
	print("[UI] Game Over! Final Score: %d" % final_score)
