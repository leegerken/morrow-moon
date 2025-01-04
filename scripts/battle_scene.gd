extends Control

@onready var player_anim: AnimationPlayer = $PlayerSprite/AnimationPlayer

func _on_exit_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_fight_button_button_up() -> void:
	$"Text Button2".show()
	$"Text Button3".show()
	$"Text Button2".grab_focus()


func _on_text_button_2_button_up() -> void:
	$"Text Button2/Menu".play()
	$"Text Button2/Cursor".visible = false
	player_anim.play("attack")
	await player_anim.animation_finished
	player_anim.play("idle")
	$"BaseMenu/Checkerboard/Box/Fight Button".grab_focus()
	$"Text Button2".hide()
