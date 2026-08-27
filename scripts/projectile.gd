extends Area2D

@export var damage = 10
@export var speed = 400.0
var velocity = Vector2.ZERO
var lifetime = 0.0
const MAX_LIFETIME = 10.0  # Remove projectile after 10 seconds

func _ready():
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	global_position += velocity * delta
	lifetime += delta
	
	if lifetime > MAX_LIFETIME:
		queue_free()

func _on_area_entered(area):
	"""Projectile hit something"""
	if area.is_in_group("enemies"):
		area.take_damage(damage)
		queue_free()
