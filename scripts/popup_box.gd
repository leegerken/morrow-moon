extends Control

signal shown
signal withdrawn

@onready var pocket_grid: InventoryUI = $Control/Pocket_Grid
@onready var anim: AnimationPlayer = $AnimationTree

var is_popup_open :bool = false

func _ready() -> void:
	self.visible = false

func _unhandled_input(event :InputEvent) -> void:
	if event is InputEventMouseButton:
		if is_popup_open:
			open()

func open() -> void:
	if is_popup_open:
		withdrawn.emit()
		anim.play("hide_popup")
		is_popup_open = false
	else:
		#get_viewport().set_input_as_handled()
		shown.emit()
		anim.play("show_popup")
		is_popup_open = true
		#pocket_grid.get_child(0).grab_focus()
