class_name PlayerState
extends State

var player: CharacterBody2D

func enter(context:Dictionary = {}) -> void:
	super()
	player.player_event.connect(on_player_event)
	player.receive_hit.connect(on_player_hit)

func exit() -> void:
	super()
	player.player_event.disconnect(on_player_event)	
	player.receive_hit.disconnect(on_player_hit)

func on_player_event(event: String) :
	pass

func on_player_hit(context: Dictionary):
	if player.invulnerable == false:
		Transition.emit(self,"hurt",context)
		player.invulnerable = true


func on_animation_finished(anim_name: StringName):
	pass
