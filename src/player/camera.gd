extends Camera2D

@onready var player: CharacterBody2D = $".."

func _ready() -> void:
	Ui.fade_transition.fade_to_bright()
	Ui.fade_transition.faded_to_black_finished.connect(on_animation_finished)



func on_animation_finished():
	if player.is_dead:
		player.death_occurred.emit()
	
