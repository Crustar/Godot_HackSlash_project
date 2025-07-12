extends Node


func play_sound(sound: StringName, delay_s:float = 0.0):
	var target: Array = []
	for child in get_children():
		if child is AudioStreamPlayer and child.name==sound :
			target.append(child)
	if target.size() == 0:
		print_debug("Sound player: no sound the the passing name found")
		return
	if target.size() > 1:
		print_debug("Sound player: multiple sound with the same name found")
		return
	if delay_s >= 0:
		await get_tree().create_timer(delay_s).timeout

	target[0].stop()
	target[0].play()


 
func stop_sound(sound: StringName):
	var target: Array = []
	for child in get_children():
		if child is AudioStreamPlayer and child.name==sound :
			target.append(child)
	if target.size() == 0:
		print_debug("Sound player: no sound the the passing name found")
		return
	if target.size() > 1:
		print_debug("Sound player: multiple sound with the same name found")
		return
	target[0].stop()
