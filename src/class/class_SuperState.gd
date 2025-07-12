class_name State
extends Node

signal Transition
#var body: CharacterBody2D
var animation : CharacterAnimationPlayer 

func enter(context:Dictionary = {}) -> void:
	animation.animation_finished.connect(on_animation_finished)

func exit() -> void:
	animation.animation_finished.disconnect(on_animation_finished)

func frame_update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func on_animation_finished(anim_name: StringName):
	pass
