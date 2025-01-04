extends Sprite2D

var brightness = material.get_shader_parameter("brightness")

var player_near :bool = false

func _on_popup_button_button_down() -> void:
	if player_near:
		brightness = -0.5
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

func _on_player_checker_area_entered(area: Area2D) -> void:
	player_near = true

func _on_player_checker_area_exited(area: Area2D) -> void:
	player_near = false
