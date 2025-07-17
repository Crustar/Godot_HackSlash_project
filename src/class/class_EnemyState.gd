class_name EnemyState
extends State

var enemy : CharacterBody2D

func enter(context:Dictionary = {}) -> void:
	super()
	enemy.receive_hit.connect(on_got_hit)
	enemy.target_found.connect(on_target_found)
	enemy.target_lost.connect(on_target_lost)

func exit() -> void:
	super()
	enemy.receive_hit.disconnect(on_got_hit)
	enemy.target_found.disconnect(on_target_found)
	enemy.target_lost.disconnect(on_target_lost)

func on_got_hit(context: Dictionary):
	if enemy.invulnerable == false:
		Transition.emit(self,"hurt",context)
		enemy.invulnerable = true

func on_target_found():
	Transition.emit(self,"chasing")

func on_target_lost():
	pass

func on_animation_finished(anim_name: StringName):
	pass
