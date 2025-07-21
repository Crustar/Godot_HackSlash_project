extends TextureRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hp: Label = $hp


func blink ():
	animation_player.play("pumping")

func set_hp (val: int):
	hp.text = str(val)
