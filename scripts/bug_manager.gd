extends Node

var bug_list :Array = []

func _ready() -> void:
	bug_list = SaveManager.current_save.bug_list

func remove_bug_entry(entry :String) -> void:
	var bug_index = bug_list.find(entry, 0)
	bug_list.remove_at(bug_index)
	SaveManager.current_save.bug_index = bug_index
