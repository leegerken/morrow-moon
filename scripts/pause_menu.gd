extends CanvasLayer

@onready var pause_menu_anim := $PauseMenu/PauseMenuAnim
@onready var status_menu_anim := $StatusMenu/StatusMenuAnim

var status_menu_open := false

#Debug
@onready var aspect_label := $AspectRatio/AspectRatioLabel
var aspect_i := 0

func open_pause_menu() -> void:
	pause_menu_anim.play("Slide Up")
	$PauseMenu/PauseMenuAnim/PauseSound.play()
	
func exit_pause_menu() -> void:
	if status_menu_open:
		exit_status_menu()
		await get_tree().create_timer(0.1).timeout
	pause_menu_anim.play("Slide Down")
	$PauseMenu/PauseMenuAnim/UnpauseSound.play()

func open_status_menu() -> void:
	status_menu_open = true
	status_menu_anim.play("Slide Up")
	
func exit_status_menu() -> void:
	status_menu_open = false
	status_menu_anim.play("Slide Down")

func _on_status_button_button_up() -> void:
	if status_menu_open:
		exit_status_menu()
	else:
		open_status_menu()
	print("Status Menu Open: ",status_menu_open)

func _on_pause_button_button_up() -> void:
	%GameManager.toggle_pause()

#func _on_screen_area_input_event(_viewport :Viewport, event :InputEvent, _shape_idx :int) -> void:
##Used to detect mouse clicks on the screen. Used to dismiss pause menu when outside screen space is clicked.
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#if get_tree().paused:
			#%GameManager.toggle_pause()

func _on_button_pressed() -> void:
	aspect_i += 1
	aspect_i = aspect_i % 4
	match aspect_i:
		0:
			aspect_label.text = "16 : 10"
			DisplayServer.window_set_size(Vector2i(1280,800))
		1:
			aspect_label.text = "16 : 9"
			DisplayServer.window_set_size(Vector2i(1280,720))
		2:
			aspect_label.text = "4 : 3"
			DisplayServer.window_set_size(Vector2i(1024,768))
		3:
			aspect_label.text = "21 : 9"
			DisplayServer.window_set_size(Vector2i(1280,540))
