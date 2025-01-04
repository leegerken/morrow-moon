extends Control

@export var icon_label :String

func _ready() -> void:
	$Label.text = icon_label
