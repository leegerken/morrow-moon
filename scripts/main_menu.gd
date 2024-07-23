extends CanvasLayer

@onready var aspect_label := $AspectRatio/AspectRatioLabel
var aspect_i := 0

func _ready() -> void:
	pass

func _on_button_button_up() -> void:
	aspect_i += 1
	aspect_i = aspect_i % 4
	match aspect_i:
		0:
			aspect_label.text = "16 : 10"
			DisplayServer.window_set_size(Vector2i(1280,800))
		1:
			aspect_label.text = "16 : 9"
			DisplayServer.window_set_size(Vector2i(1280,720))
		2:
			aspect_label.text = "4 : 3"
			DisplayServer.window_set_size(Vector2i(1024,768))
		3:
			aspect_label.text = "21 : 9"
			DisplayServer.window_set_size(Vector2i(1280,540))
			
func _on_start_button_button_up() -> void:
	$Transitions.fade_in()


func _on_transition_player_animation_finished(anim_name :String) -> void:
	if anim_name == "Fade In": get_tree().change_scene_to_file("res://scenes/game.tscn")
