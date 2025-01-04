extends Button

@export var button_text := "none"

func _on_focus_entered() -> void:
	#$Label.modulate = Color(0.500,0.500,0.500,1)
	$Label.add_theme_color_override("font_color",Color8(255,255,255,200))
	await get_tree().create_timer(0.2).timeout
	$Label.add_theme_color_override("font_color",Color8(255,255,255,255))
	
func _on_focus_exited() -> void:
	$Label.add_theme_color_override("font_color",Color8(255,235,161,255))

func _ready() -> void:
	$Label.text = button_text
	if button_text == "Fight": self.grab_focus()


func _on_button_down() -> void:
	if button_text == "Fight": return
	$Menu.play()
