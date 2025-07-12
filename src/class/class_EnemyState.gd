class_name EnemyState
extends State

var enemy : CharacterBody2D

func enter(context:Dictionary = {}) -> void:
	super()
	enemy.receive_hit.connect(on_got_hit)

func exit() -> void:
	super()
	enemy.receive_hit.disconnect(on_got_hit)

func on_got_hit(context: Dictionary):
	if enemy.invulnerable == false:
		Transition.emit(self,"hurt",context)
		enemy.invulnerable = true

	
func on_animation_finished(anim_name: StringName):
	pass
