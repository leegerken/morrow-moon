extends Sprite2D

var shader_brightness = material.get_shader_parameter("brightness")
var shader_width = material.get_shader_parameter("width")

func _on_popup_button_mouse_entered() -> void:
	shader_width = 1
	material.set_shader_parameter("width", shader_width)

func _on_popup_button_mouse_exited() -> void:
	shader_width = 0
	material.set_shader_parameter("width", shader_width)

func _on_popup_button_button_down() -> void:
	shader_brightness = -0.4
	material.set_shader_parameter("brightness", shader_brightness)
	
func _on_popup_button_button_up() -> void:
	shader_brightness = 0.0
	material.set_shader_parameter("brightness", shader_brightness)
