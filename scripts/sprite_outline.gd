extends Sprite2D

var brightness :Variant = material.get_shader_parameter("brightness")
var width :Variant = material.get_shader_parameter("width")

var player_near :bool = false

func _on_popup_button_mouse_entered() -> void:
	width = 1
	material.set_shader_parameter("width", width)

func _on_popup_button_mouse_exited() -> void:
	width = 0
	material.set_shader_parameter("width", width)

func _on_popup_button_button_down() -> void:
	if player_near:
		brightness = -0.4
		material.set_shader_parameter("brightness", brightness)

func _on_popup_button_button_up() -> void:
	if player_near:
		brightness = 0.0
		material.set_shader_parameter("brightness", brightness)

func _on_popup_button_pressed() -> void:
	if player_near:
		brightness = -0.5
		material.set_shader_parameter("brightness", brightness)
		PlayerManager.execute_interaction()
		await get_tree().create_timer(0.1).timeout
		brightness = 0.0
		material.set_shader_parameter("brightness", brightness)

func _on_player_checker_area_entered(_area: Area2D) -> void:
	width = 1
	player_near = true
	$PopupButton.disabled = false
	print("player is near")
	material.set_shader_parameter("brightness", brightness)
	material.set_shader_parameter("width", width)
	
func _on_player_checker_area_exited(_area: Area2D) -> void:
	player_near = false
	$PopupButton.disabled = true
	print("exited")
	brightness = 0.0
	material.set_shader_parameter("brightness", brightness)
	width = 0
	material.set_shader_parameter("width", width)
