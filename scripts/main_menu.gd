extends CanvasLayer

@onready var start_button: Button = $Start/StartButton

func _ready() -> void:
	start_button.grab_focus()

func title_screen_start() -> void:
	pass

func _on_start_button_button_up() -> void:
	$Transitions.fade_in()

func _on_transition_player_animation_finished(anim_name :String) -> void:
	if anim_name == "Fade In": get_tree().change_scene_to_file("res://scenes/game.tscn")
