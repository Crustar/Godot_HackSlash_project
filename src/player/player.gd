extends CharacterBody2D

@onready var dashing_sound: AudioStreamPlayer2D = $dashing_sound
@onready var jump_sound: AudioStreamPlayer2D = $jump_sound
@onready var attack_sound: AudioStreamPlayer2D = $attack_sound
@onready var hurtbox: Area2D = $Sprite/Hurtbox


const SPEED = 300.0
const DASH_SPEED = 600
const JUMP_VELOCITY = 400.0
const MAX_SPEED = 600.0
const MAX_JUMP_VELOCITY = 700.0
const ACCELERATION = 700.0
const FRICTION = 1400.0



var max_jump = 2 #This number counts the initial jump, so 1 mid-air
var jump_count = 0
var max_dash = 1
var dash_count = 0

signal player_event
signal receive_hit


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy_hit_box"):
		receive_hit.emit(area.global_position)

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

func play_jump_sound():
	jump_sound.stop()
	jump_sound.play()
	
func play_dash_sound():
	dashing_sound.stop()
	dashing_sound.play()
	
func play_attack_sound():
	pass
	#attack_sound.stop()
	#attack_sound.play()
	
