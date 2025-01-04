extends Node

@onready var ground: Node2D = $Map/TileMap/Ground

var unpauseable :bool = false

func _unhandled_input(_event :InputEvent) -> void:	
	if Input.is_action_just_pressed("cancel") and %Player.player_state == "sleeping":
		get_tree().paused = false
		%Player.exit_sleep()

func update_tile_selector(position :Vector2) -> Vector2i:
	var tile_position :Vector2i = position
	tile_position = Vector2i(tile_position.x - (tile_position.x % 16), tile_position.y - (tile_position.y % 16))
	$Map/TileMap/Ground/Sprite2D.position = tile_position
	print(tile_position)
	return tile_position
	
func dig_position(tile_position :Vector2i) -> void:
	var cell :Array[Vector2i] = [$Map/TileMap/Ground.local_to_map(tile_position)]
	print(cell)
	ground.change_to_dirt(cell)
	
