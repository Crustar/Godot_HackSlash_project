extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal faded_to_black_finished
signal faded_to_bright_finished

func _ready() -> void:
	$ColorRect.visible = true

func fade_to_black():
	animation_player.play("fade_to_black")

func fade_to_bright():
	animation_player.play("fade_to_bright")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		faded_to_black_finished.emit()
	elif anim_name == "fade_to_bright":
		faded_to_bright_finished.emit()
