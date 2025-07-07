extends Area2D

@onready var animation_player: AnimationPlayer = %AnimationPlayer



func _on_area_entered(hitbox:Area2D):
	if hitbox.is_in_group("Character_hit_box"):
		animation_player.play("hurt")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation_player.play("RESET")
