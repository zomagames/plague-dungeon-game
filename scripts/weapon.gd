extends Node

const PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")

@export var weapon_type = "basic"
@export var fire_rate = 0.1  # seconds between shots
@export var projectile_damage = 10
@export var projectile_speed = 400.0

var fire_timer = 0.0
var player: Node2D

func _ready():
	player = get_parent()

func _physics_process(delta):
	fire_timer -= delta
	
	if fire_timer <= 0:
		fire_in_all_directions()
		fire_timer = fire_rate

func fire_in_all_directions():
	"""Fire projectiles in all directions (omnidirectional)"""
	var directions = 8  # 8 projectiles in cardinal and diagonal directions
	
	for i in range(directions):
		var angle = (TAU / directions) * i  # TAU = 2π
		fire_projectile(angle)

func fire_projectile(angle: float):
	"""Fire a single projectile in a specific direction"""
	var projectile = PROJECTILE_SCENE.instantiate()
	get_parent().get_parent().add_child(projectile)
	
	projectile.global_position = player.global_position
	projectile.velocity = Vector2(cos(angle), sin(angle)) * projectile_speed
	projectile.damage = projectile_damage

func upgrade_damage(amount: int):
	"""Upgrade weapon damage"""
	projectile_damage += amount
	
func upgrade_fire_rate(amount: float):
	"""Upgrade fire rate (lower = faster)"""
	fire_rate = max(0.05, fire_rate - amount)
