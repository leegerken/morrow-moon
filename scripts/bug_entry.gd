class_name BugEntry extends PanelContainer

@onready var label: Label = $Label

var bug_text :String

func _ready() -> void:
	$Label/Button.visible = false

func initialize(a :String) -> void:
	bug_text = a
	label.text = bug_text

func _on_mouse_entered() -> void:
	$Label/Button.visible = true

func _on_mouse_exited() -> void:
	$Label/Button.visible = false

func _on_button_button_down() -> void:
	$Label/Button.modulate = Color(0.500,0.500,0.500,1)

func _on_button_button_up() -> void:
	$Label/Button.modulate = Color(1,1,1,1)

func _on_button_pressed() -> void:
	BugManager.remove_bug_entry(bug_text)
	self.visible = false
