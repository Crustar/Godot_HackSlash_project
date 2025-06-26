class_name PlayerState
extends State

var player: CharacterBody2D
var animation : CharacterAnimationPlayer 

func enter() -> void:
	player.player_event.connect(on_player_event)

func exit() -> void:
	player.player_event.disconnect(on_player_event)	

func on_player_event(event: String) :
	pass
