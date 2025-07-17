extends CharacterBody2D

const CHASE_SPEED = 60.0
const PATROL_SPEED = 20.0
const DASH_SPEED = 600
const JUMP_VELOCITY = 200.0
const MAX_SPEED = 600.0
const MAX_JUMP_VELOCITY = 700.0
const ACCELERATION = 700.0
const FRICTION = 1400.0


var is_dead = false
var invulnerable = false

var is_chasing : bool = false
var have_sight : bool = false

var home_coord : Vector2		# TODO: Implement home patrol
var patrol_range : int = 200

signal receive_hit
signal death_occurred
signal target_found
signal target_lost


@onready var enemy_chase_brain: Node2D = $EnemyChaseBrain
@onready var health: Health = $Health
@onready var hitbox: HitBox = $Sprite/Hitbox


func _ready() -> void:
	# Connecting signals
	death_occurred.connect(on_death_occurred)
	enemy_chase_brain.target_found.connect(on_target_found)
	enemy_chase_brain.target_lost.connect(on_target_lost)

func _physics_process(delta: float) -> void:
	if is_chasing:
		pass



func toggle_collision(val: bool):
	velocity = Vector2.ZERO
	$Collision.set_deferred("disabled",!val)

func toggle_attack(val: bool):
	for child in hitbox.get_children():
		if child is CollisionShape2D :
			child.set_deferred("disabled",!val)

func get_chase_data() -> Vector2:
	return enemy_chase_brain.get_chase_data()


func on_death_occurred():
	self.queue_free()

func on_target_found():
	is_chasing = true
	have_sight = true
	self.target_found.emit()

func on_target_lost():
	have_sight = false
	self.target_lost.emit()
