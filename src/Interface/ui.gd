extends CanvasLayer

@onready var heart: TextureRect = $Heart
@onready var fade_transition: CanvasLayer = $FadeTransition


func blink_heart():
	heart.blink()

func set_hp(val: int):
	heart.set_hp(val)
