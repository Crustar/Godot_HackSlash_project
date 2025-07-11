extends CharacterBody2D

const SPEED = 150.0
const PATROL_SPEED = 50.0
const DASH_SPEED = 600
const JUMP_VELOCITY = 400.0
const MAX_SPEED = 600.0
const MAX_JUMP_VELOCITY = 700.0
const ACCELERATION = 700.0
const FRICTION = 1400.0

var is_dead = false
var invulnerable = false

signal receive_hit
signal death_occurred

@onready var health: Health = $Health
@onready var hitbox: HitBox = $Sprite/Hitbox


func _ready() -> void:
	death_occurred.connect(on_death_occurred)
	

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Character_hit_box") and !invulnerable:
		receive_hit.emit({"pos":area.global_position})
		health.damage_taken(area.damage)

func on_death_occurred():
	self.queue_free()

## TODO: currently turn this on will cause the enemy to fall through the ground
func toggle_collision(val: bool):
	velocity = Vector2(0,0)
	$Collision.disabled = true

func toggle_attack(val: bool):
	for child in hitbox.get_children():
		if child is CollisionShape2D :
			child.disabled = val
