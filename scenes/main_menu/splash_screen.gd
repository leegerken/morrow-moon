extends Control

func _ready() -> void:
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
