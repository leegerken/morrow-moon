class_name PlayerCameraNode extends Camera2D

func _ready() -> void:
	MapManager.TileMapBoundsChanged.connect(update_limits)
	update_limits(MapManager.current_tilemap_bounds)
	pass
	
func update_limits(bounds :Array[Vector2]) -> void:
	if bounds == []:
		return
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)
	pass
