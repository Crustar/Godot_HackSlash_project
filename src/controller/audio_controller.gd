extends Node

func play_attack_sound(delay_s: int = 0):
	if delay_s >= 0:
		await get_tree().create_timer(delay_s).timeout
	$Attack.stop()
	$Attack.play()
	
func play_dash_sound():
	$Dash.stop()
	$Dash.play()
	
func play_jump_sound():
	$Jump.stop()
	$Jump.play()
