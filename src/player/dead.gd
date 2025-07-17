extends PlayerState

# State: dead
# behavior:
#	play the dead animation (which also activate hitbox)
#	lock any movement input
#	follow passive physic (gravity)
# trasition:
#	none, deadend state

@onready var camera: Camera2D = $"../../Camera"


func enter(context:Dictionary = {}) -> void:
	super()
	player.velocity.x = 0
	animation.play("dead")



func exit() -> void:
	super()
	pass

func frame_update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	# Physic logic
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	
	# Transition logic



func on_player_event(event: String) :
	match event:
		_:
			pass


func on_animation_finished(anim_name: StringName) -> void:
	player.death_occurred.emit()
