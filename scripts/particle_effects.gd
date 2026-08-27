extends Node2D
class_name ParticleEffect

# Smoke effect sprites for level-up, kills, etc.
var smoke_sprites = [
	"res://sprites/Free Smoke Fx  Pixel 01.png",
	"res://sprites/Free Smoke Fx  Pixel 02.png",
	"res://sprites/Free Smoke Fx  Pixel 03.png",
]

func _ready():
	pass

func spawn_smoke_effect(position: Vector2, effect_type: int = 0):
	"""Spawn smoke effect at position"""
	var sprite = Sprite2D.new()
	sprite.texture = load(smoke_sprites[effect_type % smoke_sprites.size()])
	sprite.position = position
	sprite.scale = Vector2(1.5, 1.5)
	sprite.modulate = Color(1, 1, 0.5, 1)  # Yellow-ish smoke
	
	add_child(sprite)
	
	# Animate fade out
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite, "position", position + Vector2(0, -50), 1.0)
	tween.tween_property(sprite, "modulate:a", 0.0, 1.0)
	tween.tween_callback(sprite.queue_free)

func spawn_level_up_effect(position: Vector2):
	"""Spawn special effect for level-up"""
	var effect_sprite = Sprite2D.new()
	effect_sprite.texture = load(smoke_sprites[1])  # Use middle smoke effect
	effect_sprite.position = position
	effect_sprite.scale = Vector2(2.0, 2.0)
	effect_sprite.modulate = Color(0, 1, 1, 1)  # Cyan for level-up
	
	add_child(effect_sprite)
	
	# Animate: scale up and fade
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(effect_sprite, "scale", Vector2(3.0, 3.0), 0.8)
	tween.tween_property(effect_sprite, "modulate:a", 0.0, 0.8)
	tween.tween_callback(effect_sprite.queue_free)
	
	print("[ParticleEffect] Level-up effect spawned at: ", position)

func spawn_kill_effect(position: Vector2):
	"""Spawn effect when enemy dies"""
	for i in range(3):
		var sprite = Sprite2D.new()
		sprite.texture = load(smoke_sprites[i % smoke_sprites.size()])
		sprite.position = position
		sprite.scale = Vector2(1.2, 1.2)
		sprite.modulate = Color(1, 0.3, 0, 1)  # Orange for kill
		
		add_child(sprite)
		
		# Scatter in different directions
		var angle = (TAU / 3.0) * i
		var direction = Vector2(cos(angle), sin(angle))
		
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(sprite, "position", position + direction * 60, 0.8)
		tween.tween_property(sprite, "modulate:a", 0.0, 0.8)
		tween.tween_callback(sprite.queue_free)
