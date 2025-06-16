class_name ColorTilemapLayer
extends TileMapLayer

var _update_callables : Dictionary[Vector2i, Callable]


func update_tile(coords: Vector2i, callable: Callable) -> void:
	_update_callables[coords] = callable
	notify_runtime_tile_data_update()


func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	return _update_callables.has(coords)


func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	if not _update_callables.has(coords):
		return
	_update_callables[coords].call(tile_data)
