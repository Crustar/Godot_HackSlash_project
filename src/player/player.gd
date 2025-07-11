extends CharacterBody2D


@onready var hurtbox: Area2D = $Sprite/Hurtbox
@onready var health: Health = $Health


const SPEED = 300.0
const DASH_SPEED = 600
const JUMP_VELOCITY = 400.0
const MAX_SPEED = 600.0
const MAX_JUMP_VELOCITY = 700.0
const ACCELERATION = 700.0
const FRICTION = 2000.0



var max_jump = 2 #This number counts the initial jump, so 1 mid-air
var jump_count = 0
var max_dash = 1
var dash_count = 0


var is_dead = false
var invulnerable = false



signal player_event
signal receive_hit
signal death_occurred



func _ready() -> void:
	death_occurred.connect(on_death_occurred)

var last_direction = 0
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		player_event.emit("up")
	if Input.is_action_just_pressed("down"):
		player_event.emit("down")
	if Input.is_action_just_pressed("jump"):
		player_event.emit("jump")
	if Input.is_action_just_pressed("dash"):
		player_event.emit("dash")
	if Input.is_action_just_pressed("attack"):
		player_event.emit("attack")
		
	var direction = Input.get_axis("left", "right")
	if direction == 0 and last_direction != 0:
		player_event.emit("no_left_no_right")
	elif direction == -1 and last_direction != -1:
		player_event.emit("left")
	elif direction == 1 and last_direction != 1:
		player_event.emit("right")	
	last_direction = direction



func on_death_occurred():
	get_tree().reload_current_scene()



	
