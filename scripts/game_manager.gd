extends Node

func _process(_delta :float) -> void:
	pass
	
func _unhandled_input(_event :InputEvent) -> void:	
	if Input.is_action_just_pressed("pause"): toggle_pause()
	
func toggle_pause() -> void:
	if get_tree().paused:
		$PauseMenu.exit_pause_menu()
	else:
		$PauseMenu.open_pause_menu()
	get_tree().paused = not get_tree().paused
