extends Camera2D

@onready var fade_black: CanvasLayer = $FadeBlack
@onready var player: CharacterBody2D = $".."

func _ready() -> void:
	fade_black.visible = true
	fade_black.fade_to_bright()
	fade_black.fading_finished.connect(on_animation_finished)

func fade_to_black():
	fade_black.fade_to_black()
	
func fade_to_bright():
	fade_black.fade_to_bright()

func on_animation_finished(anim_name: StringName):
	if anim_name == "fade_to_black" and player.is_dead:
		player.death_occurred.emit()
	
