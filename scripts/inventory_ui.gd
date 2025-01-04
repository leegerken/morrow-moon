class_name InventoryUI extends Control

#signal inventory_cleared

const INVENTORY_SLOT = preload("res://scenes/inventory_slot.tscn")
var focus_index :int = 0
@export var data :InventoryData

@onready var popup_box: Control = $"../.."
@onready var blank_grid: GridContainer = $"../Pocket_Grid2"

func _ready() -> void:
	popup_box.shown.connect(clear_inventory)
	popup_box.withdrawn.connect(clear_inventory)
	data.changed.connect(on_inventory_changed)
	data.item_added.connect(on_inventory_changed)
	#inventory_cleared.connect(update_inventory)
	#clear_inventory()
	#update_inventory()
	blank_grid.visible = false

func clear_inventory() -> void:
	print("inventory cleared")
	blank_grid.visible = true
	for c in get_children():
		c.queue_free()
	await get_tree().create_timer(0.05).timeout
	blank_grid.visible = false
	update_inventory()

func update_inventory() -> void:
	print("inventory updated")
	for s in data.slots:
		var new_slot := INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
		new_slot.focus_entered.connect(item_focused)
	get_child(0).grab_focus()

func on_inventory_changed() -> void:
	clear_inventory()
	#update_inventory()

func item_focused() -> void:
	for i in get_child_count():
		if get_child(i).has_focus:
			focus_index = i
			print(focus_index)
			return
	
