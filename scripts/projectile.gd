extends Area2D

# Multiple projectile/bullet sprites for variety
var projectile_sprites = [
	"res://sprites/Fire Effect and Bullet 16x16.png",
	"res://sprites/Water Effect and Bullet 16x16.png",
	"res://sprites/Purple Effect and Bullet 16x16.png",
	"res://sprites/Green Effect and Bullet 16x16.png",
]

@export var damage = 10
@export var speed = 400.0
var velocity = Vector2.ZERO
var lifetime = 0.0
const MAX_LIFETIME = 10.0  # Remove projectile after 10 seconds

func _ready():
	area_entered.connect(_on_area_entered)
	
	# Load random projectile sprite
	var sprite = $Sprite2D
	var random_projectile = projectile_sprites[randi() % projectile_sprites.size()]
	var projectile_texture = load(random_projectile)
	
	if projectile_texture:
		sprite.texture = projectile_texture
	
	print("[Projectile] Fired with sprite: %s" % random_projectile)

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
