class_name PlayerMenuNode extends CanvasLayer

var base_menu_is_active :bool = false
var stats_menu_is_active :bool = false

@onready var menus: Control = $Menus
@onready var base_menu: Control = $Menus/BaseMenu
@onready var stats_menu: Control = $Menus/StatsMenu
@onready var anim: AnimationPlayer = $Menus/PlayerMenuAnim
@onready var day_count: Label = $Menus/BaseMenu/Date/HBoxContainer/Day
@onready var month: Label = $Menus/BaseMenu/Date/HBoxContainer/Month

func _ready() -> void:
	self.visible = true
	base_menu.visible = false
	stats_menu.visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_on_close_button_pressed()

func show_base_menu() -> void:
	update_date()
	base_menu_is_active = true
	anim.play("show_base_menu")
	$Menus/MenuButton/MenuOpenSound.play()
	get_tree().paused = true
	print("Show base menu.")
	
func hide_base_menu() -> void:
	base_menu_is_active = false
	anim.play("hide_base_menu")
	$Menus/MenuButton/MenuCloseSound.play()
	get_tree().paused = false
	print("Hide base menu.")
	
func show_stats_menu() -> void:
	stats_menu_is_active = true
	anim.play("show_stats_menu")
	
func hide_stats_menu() -> void:
	stats_menu_is_active = false
	anim.play("hide_stats_menu")
	
func hide_all() -> void:
	hide_stats_menu()
	await get_tree().create_timer(0.3).timeout
	hide_base_menu()

func _on_stats_menu_button_pressed() -> void:
	if not stats_menu_is_active:
		show_stats_menu()
		return
	else:
		hide_stats_menu()

func _on_close_button_pressed() -> void:
	if not base_menu_is_active:
		show_base_menu()
		return
	elif stats_menu_is_active:
		hide_all()
		return
	else:
		hide_base_menu()
		return

func _on_button_pressed() -> void:
	$Book.play("default")
	
func update_date() -> void:
	var suffix :String
	var array :Array = DateData.day_num_to_date(GlobalData.day_count)
	if array[0] > 10 and array[0] < 14:
		suffix = "th"
	else:
		match array[0] % 10:
			1: suffix = "st"
			2: suffix = "nd"
			3: suffix = "rd"
			_: suffix = "th"
	day_count.text = str(array[0]) + suffix
	month.text = array[1] + "."

func _on_date_button_up() -> void:
	GlobalData.day_count += 1
	update_date()
