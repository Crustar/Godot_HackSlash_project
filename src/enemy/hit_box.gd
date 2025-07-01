extends Area2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer



func _on_area_entered(area: Area2D) -> void:
	print_debug(area.name)
	if area.is_in_group("Character_attack_zone"):
		print_debug("playing animation")
		animation_player.play("hurt")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("RESET")
