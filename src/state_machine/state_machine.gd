extends Node

@export var initial_state : PlayerState
@export var player_node : CharacterBody2D
@export var animation_player_node : CharacterAnimationPlayer
var current_state: PlayerState
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is PlayerState :
			states[child.name.to_lower()] = child
			child.player = player_node
			child.animation = animation_player_node
			child.Transition.connect(on_state_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_state.frame_update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)





func on_state_transition(source_state:PlayerState, new_state_name:String):
	if source_state!=current_state :
		print_debug("State passing as argument is not the current state")
		return
		
	var new_state : PlayerState = states.get(new_state_name.to_lower())
	if !new_state :
		print_debug("State that is transitioned into does not exist")
		return
		
	if current_state :
		current_state.exit()
	else:
		print_debug("State machine's current state is lost")
	
	new_state.enter()
	current_state = new_state
	
	
	
	
	
	
	
	
	
