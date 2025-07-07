class_name PlayerState
extends State

var player: CharacterBody2D
var animation : CharacterAnimationPlayer 

func enter(context:Dictionary = {}) -> void:
	player.player_event.connect(on_player_event)
	player.receive_hit.connect(on_player_hit)
	animation.animation_finished.connect(on_animation_finished)

func exit() -> void:
	player.player_event.disconnect(on_player_event)	
	player.receive_hit.disconnect(on_player_hit)
	animation.animation_finished.disconnect(on_animation_finished)

func on_player_event(event: String) :
	pass

func on_player_hit(context: Dictionary):
	pass
	
func on_animation_finished(anim_name: StringName):
	pass
