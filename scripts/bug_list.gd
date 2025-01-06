extends Control

const BUG_ENTRY :PackedScene = preload("res://scenes/bug_entry.tscn")

@onready var anim: AnimationPlayer = $Background/AnimationPlayer
@onready var input: LineEdit = $Background/TextEntry/LineEdit
@onready var bug_entry_container: VBoxContainer = $Background/BugList/ScrollContainer/MarginContainer/BugEntryContainer

var is_open :bool = false
var bug_list :Array = []

func _ready() -> void:
	$Background.visible = false
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	bug_list = SaveManager.current_save.bug_list

func show_bug_list() -> void:
	initialize_list()
	$Background.visible = true
	is_open = true
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	get_tree().paused = true
	anim.play("show_bug_menu")
	
func hide_bug_list() -> void:
	is_open = false
	$BugButton/ButtonSound.play()
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().paused = false
	anim.play("hide_bug_menu")
	await anim.animation_finished
	$Background.visible = false
	SaveManager.save_game()
	
func _on_line_edit_text_submitted(new_text: String) -> void:
	input.clear()
	BugManager.bug_list.append(new_text)
	initialize_list()
	SaveManager.current_save.bug_list = BugManager.bug_list

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("GUI INPUT")
		_on_bug_button_pressed()

func _on_bug_button_pressed() -> void:
	if is_open:
		hide_bug_list()
	else: show_bug_list()

func initialize_list() -> void:
	for i in bug_entry_container.get_children():
		i.queue_free()
	
	for i in BugManager.bug_list:
		var new_bug_entry = BUG_ENTRY.instantiate()
		bug_entry_container.add_child(new_bug_entry)
		new_bug_entry.initialize(i)
	
