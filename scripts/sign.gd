extends StaticBody2D

@export var Dialogue :DialogueResource

var player_near := false

func _unhandled_input(event :InputEvent) -> void:
	if event.is_action_pressed("confirm"):
		if player_near: read_sign()
		

func read_sign():
	DialogueManager.show_dialogue_balloon(Dialogue,"main")
	DialogueManager.dialogue_ended
	
func _on_sign_interact_area_area_entered(area :Area2D):
	print(area.to_string())
	player_near = true

func _on_sign_interact_area_area_exited(area):
	player_near = false
