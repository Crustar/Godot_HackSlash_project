extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal fading_finished

func fade_to_black():
	animation_player.play("fade_to_black")

func fade_to_bright():
	animation_player.play("fade_to_bright")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	fading_finished.emit(anim_name)
