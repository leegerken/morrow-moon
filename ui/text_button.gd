extends Button

@export var label_text :String

func _ready() -> void:
	$Label.text = label_text

func _on_pressed() -> void:
	$ButtonSound.play()
	$AnimationTree.play("Pressed")

#func _on_button_down():
	#$Label.visible = false
	#$Underline.visible = false
	
#func _on_button_up():
	#$Label.visible = true
	#$Underline.visible = true
