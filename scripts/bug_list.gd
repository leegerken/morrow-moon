extends Control

@onready var anim: AnimationPlayer = $Background/AnimationPlayer

func _ready() -> void:
	pass
	#$Background.hide()

func show_bug_list() -> void:
	#get_viewport().set_input_as_handled()
	#Starts when bug button is pressed.
	get_tree().paused = true
	anim.play("show_bug_menu")
	#$Background.show()
	
func hide_bug_list() -> void:
	get_tree().paused = false
	anim.play("hide_bug_menu")
	#$Background.hide()
