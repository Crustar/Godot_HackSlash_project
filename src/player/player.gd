# The scene represents the playable character and its control components. It has
# 6 direct child nodes: Health, Sprite, Collision, AnimationPlayer, camera and
# a state machine.

# The main node "player" defines basic parameters of the character (moving speed
# and acceleration etc) as well as high level object behavior like spawning (which
# currently has no functional logic in _ready()) and despawning/death. It also
# handles the raw input into more refined event for the state machine to process.

# The "Health" node is a universal class that handles logic of a body being hit
# by a hitbox. This includes modifying hp value and triggering a receive_hit event.

# The "Sprite" node contains a group of sub-nodes that should be following the
# character's visual component, like particles and different hitbox for various
# attacks.

# The "Collision" is self-explanitory.

# The "AnimationPlayer" node (which is also a self defined class that has the 
# additional effect of flipping sprite) manage the sprite animation as well as
# controlling the activation of different hitbox upon player attacking.

# The "Camera" node creates a player-centered camera and camera-related effects
# like fade to black.

# The "state-machine" node itself is a handler to keep a state machine logic of
# the player turning by reading all of its child nodes (that are PlayerState 
# class) and connect their logic to a central control.


extends CharacterBody2D

@onready var hurtbox: Area2D = $Sprite/Hurtbox
@onready var health: Health = $Health


const SPEED = 300.0
const DASH_SPEED = 600
const JUMP_VELOCITY = 400.0
const MAX_SPEED = 600.0
const MAX_JUMP_VELOCITY = 700.0
const ACCELERATION = 700.0
const FRICTION = 3000.0



var max_jump = 2 #This number counts the initial jump, so 1 mid-air
var jump_count = 0
var max_dash = 1
var dash_count = 0


var is_dead = false
var invulnerable = false


## [b]A signal that triggers upon player inputting keys.[/b][br][br]Its [method Signal.connect]
## method call can be found in the [param PlayerState] class. Practically 
## speaking, whenever the state machine transits, it connects this signal to the 
## current state's [param on_player_event()] method. Its [method Signal.emit] can be found
## later in this script, in the [param _process()] method. Each frame, the raw key
## input would be translated into a [String] that represent the relevant event and
## passed as the argument of the [method Signal.emit] method.
signal player_event

## [b]A signal that triggers upon a hitbox of an enemy attack enters the character's
## hurtbox. [/b][br][br]
## The main purpose of this signal is to manage animation like knockbacks[br][br]
## Its [method Signal.connect] method call can be found in
## the [param PlayerState] class. Practically speaking, whenever the state machine
## transits, it connects this signal to the current state's [param on_player_hit()] 
## method. [br][br]Its [method Signal.emit] can be found in the [param Health]
## component. This component checks if the hit is legit (ex. enemy hitting enemy
## shouldn't trigger a hit) and passing the corresponding context through the call
## (like damage and the position here the hit is originated).
signal receive_hit

## [b]A signal that triggers upon the end of life of the body.[/b][br][br]Its
## [method Signal.connect] method call can be found in this script, in [param _ready()]
## and it's connected to the [param on_death_occurred()] method later in this
## script.[br][br]Its [method Signal.emit] can be found in the [param Camera] node
## It is called when the camera fades in black.[br][br]
## TODO: This way of doing currently lacks logic in a scene setting, should delegate
##       The call to the main scene
signal death_occurred



func _ready() -> void:
	health.health_updated.connect(on_health_update)
	death_occurred.connect(on_death_occurred)
	Ui.set_hp(health.health)

# Every frame, the game checks if certain keys are just pressed and emit the
# [player_event] signal with the corresponding String. It is used for the states
# under the state machine to handle player input
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
		
	# the following check is usefull for the "running" state, since it is the
	# exceptional state that checks if multiple keys are NOT pressed
	var direction = Input.get_axis("left", "right")
	if direction == 0 and last_direction != 0:
		player_event.emit("no_left_no_right")
	elif direction == -1 and last_direction != -1:
		player_event.emit("left")
	elif direction == 1 and last_direction != 1:
		player_event.emit("right")	
	last_direction = direction


## TODO: This method is a placeholder logic to simplly reset the current scene.
## 		 It should be delegated to the scene itself to manage.
func on_death_occurred():
	get_tree().reload_current_scene()

func on_health_update(current_health: float):
	Ui.set_hp(current_health as int)
