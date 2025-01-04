class_name DialogueSystemNode extends CanvasLayer

var is_active :bool = false

@onready var dialogue_ui: Control = $DialogueUI
@onready var anim: AnimationPlayer = $DialogueUI/AnimationPlayer

func _ready() -> void:
	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
			return
		return
	hide_dialog()
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"confirm"):
		if not is_active:
			show_dialog()
		else:
			hide_dialog()
	pass

func show_dialog() -> void:
	is_active = true
	dialogue_ui.visible = true
	anim.play("show_dialog")
	dialogue_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	pass
	
func hide_dialog() -> void:
	is_active = false
	dialogue_ui.visible = false
	dialogue_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	pass
