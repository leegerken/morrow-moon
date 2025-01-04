extends CanvasLayer

@onready var pause_menu_anim := $PauseMenu/PauseMenuAnim
@onready var status_menu_anim := $StatusMenu/StatusMenuAnim
@onready var knowledge_menu_anim := $KnowledgeMenu/KnowledgeMenuAnim

var status_menu_open := false
var knowledge_menu_open := false

func open_pause_menu() -> void:
	pause_menu_anim.play("Slide Up")
	$PauseMenu/PauseMenuAnim/PauseSound.play()
	$PauseMenu/HBoxContainer/StatusButton/StatusButton.grab_focus()
	
func exit_pause_menu() -> void:
	if knowledge_menu_open:
		exit_knowledge_menu()
		await get_tree().create_timer(0.2).timeout
	if status_menu_open:
		exit_status_menu()
		await get_tree().create_timer(0.1).timeout
	pause_menu_anim.play("Slide Down")
	$PauseMenu/PauseMenuAnim/UnpauseSound.play()

func open_status_menu() -> void:
	status_menu_open = true
	status_menu_anim.play("Slide Up")
	
func exit_status_menu() -> void:
	if knowledge_menu_open:
		exit_knowledge_menu()
		await get_tree().create_timer(0.2).timeout
	status_menu_open = false
	status_menu_anim.play("Slide Down")

func open_knowledge_menu() -> void:
	knowledge_menu_open = true
	knowledge_menu_anim.play("Slide Out")
	
func exit_knowledge_menu() -> void:
	knowledge_menu_open = false
	knowledge_menu_anim.play("Slide In")

func _on_knowledge_pressed() -> void:
	if knowledge_menu_open:
		exit_knowledge_menu()
	else:
		open_knowledge_menu()
		
func _on_status_button_pressed() -> void:
	if status_menu_open:
		exit_status_menu()
	else:
		open_status_menu()

func _on_pause_button_pressed() -> void:
	if not %GameManager.pause_menu_disabled:
		%GameManager.toggle_pause()

func _on_quit_button_pressed() -> void:
	%GameManager.quit_game()
