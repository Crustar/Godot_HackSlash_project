# This state machine serves as a framework for various states, each defines particular
# logic about the character's sprite animation and how the character should react 
# to different events (ex. the character would act differently as "jump" is being
# pressed between "attack" state and the "idle" state. The latter would likely to
# have the character jump into the air while the former would likely do nothing
# if the attack can't be canceled). States transit to each other once certain 
# conditions are met (ex. if the "left" key or the "right" key is pressed, the 
# character would transit from "idle" state to "running" state). The state machine
# choose which state the machine is on according to the transition logic and delegate
# the player's _process() and _physic_process() to that state.

extends Node

@export var initial_state : PlayerState
@export var player_node : CharacterBody2D
@export var animation_player_node : CharacterAnimationPlayer
var current_state: PlayerState
var states: Dictionary = {}
var pending_context: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is PlayerState :
			## for every child that is a PlayerState
			states[child.name.to_lower()] = child
			child.player = player_node
			child.animation = animation_player_node
			child.Transition.connect(on_state_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state





func _process(delta: float) -> void:
	current_state.frame_update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)





func on_state_transition(source_state:PlayerState, new_state_name:String, context:Dictionary = {}):
	if source_state!=current_state :
		print_debug("State passing as argument is not the current state: source state = " + source_state.name + " current state = " + current_state.name )
		return
		
	var new_state : PlayerState = states.get(new_state_name.to_lower())
	if !new_state :
		print_debug("State that is transitioned into does not exist")
		return
		
	if current_state :
		current_state.exit()
	else:
		print_debug("State machine's current state is lost")
	
	new_state.enter(context)
	current_state = new_state
	
	
	
	
	
	
	
	
	
