extends Node

const SAVE_PATH :String = "user://"

signal game_loaded
signal game_saved

func _ready() -> void:
	load_game()

var current_save :Dictionary = {
	scene_path = "",
	player = {
		pos_x = 0,
		pos_y = 0,
	},
	bug_list = []
}

func save_game() -> void:
	var save_file = FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	save_file.store_line(save_json)
	game_saved.emit()
	print("Game Saved")
	
func load_game() -> void:
	var save_file = FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	var save_json = JSON.new()
	save_json.parse(save_file.get_line())
	var save_dict :Dictionary = save_json.get_data() as Dictionary
	current_save = save_dict
	
func update_bug_list_data(bug_array :Array) -> void:
	current_save.bug_list = bug_array
