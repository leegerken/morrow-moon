extends Control

@onready var outline: PanelContainer = $Control/Outline
@onready var anim: AnimationPlayer = $Control/AnimationPlayer

func _ready() -> void:
	outline.visible = false
	pass


func _on_button_mouse_entered() -> void:
	#outline.modulate = Color(0.500,0.500,0.500,1)
	outline.visible = true
	#print("entered")

func _on_button_mouse_exited() -> void:
	#outline.modulate = Color(1,1,1,1)
	outline.visible = false
	#print("exited")

func rotate_180() -> void:
	anim.play("Rotate_180")
