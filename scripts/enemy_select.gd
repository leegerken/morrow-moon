extends Button

func _ready() -> void:
	self.hide()
	$Cursor.visible = false


func _on_focus_entered() -> void:
	$Cursor.visible = true
	$Menu.play()


func _on_focus_exited() -> void:
	$Cursor.visible = false
