extends Button

@export var default_button_sound :bool = true

func _on_pressed() -> void:
	if default_button_sound:
		$ButtonSound.play()

func _on_mouse_entered() -> void:
	self.modulate = Color(0.500,0.500,0.500,1)

func _on_mouse_exited() -> void:
	self.modulate = Color(1,1,1,1)

func _on_button_down() -> void:
	self.scale = Vector2(0.9,0.9)

func _on_button_up() -> void:
	self.scale = Vector2(1,1)

func _on_focus_entered() -> void:
	self.modulate = Color(0.500,0.500,0.500,1)

func _on_focus_exited() -> void:
	self.modulate = Color(1,1,1,1)
