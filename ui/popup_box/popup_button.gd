extends Button

@export var button_text :String = ""
@export var flip_v :bool = false

@onready var label :Label = $ButtonText

func _ready() -> void:
	if flip_v:
		$Panel.flip_v = true
	label.text = button_text

func _on_button_down() -> void:
	$Panel.self_modulate = Color(0.500,0.500,0.500,1)
	#self.scale = Vector2(0.9,0.9)

func _on_button_up() -> void:
	$Panel.self_modulate = Color(1,1,1,1)
	#self.scale = Vector2(1,1)
