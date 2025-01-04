class_name LevelTileMapNode extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MapManager.ChangeTileMapBounds(get_tilemap_bounds())

func get_tilemap_bounds() -> Array[Vector2]:
	var bounds :Array[Vector2] = []
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)
	)
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size)
	)
	return bounds
	
func change_to_dirt(cell :Array[Vector2i]) -> void:
	if get_cell_source_id(cell[0]) == 0:
		self.set_cells_terrain_connect(cell,0,0,false)
	if %Farming.get_cell_source_id(cell[0]) == 3:
		%Farming.set_cells_terrain_connect(cell,1,-1,false)
	elif get_cell_atlas_coords(cell[0]) == Vector2i(2,1):
		%Farming.set_cells_terrain_connect(cell,1,0,false)
