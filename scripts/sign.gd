extends StaticBody2D

func _input(event):
	if event.is_action_pressed("confirm"):
		read_sign()

func read_sign():
	DialogueManager.show_dialogue_balloon(load("res://scripts/dialog/main.dialogue"),"main")
