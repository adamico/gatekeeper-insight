class_name SonarArea
extends Area2D

@export var min_radius := 16.0
@export var max_radius := min_radius * 8
@export var radius_step := 10.0
var current_radius: float

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func _ready() -> void:
	body_shape_entered.connect(_on_body_shape_entered)


func _process(delta: float) -> void:
	var circle: CircleShape2D = collision_shape_2d.shape
	current_radius += radius_step * delta
	if current_radius > max_radius:
		current_radius = min_radius

	circle.radius = current_radius


func _on_body_shape_entered(
	body_rid: RID, body: Node2D,
	_body_shape_index: int,
	_local_shape_index: int
) -> void:
	if body is TileMapLayer:
		var tile_position: Vector2i = body.get_coords_for_body_rid(body_rid)
		var colored_tile_map: ColorTilemapLayer = get_tree().get_first_node_in_group("colored_tilemap")
		colored_tile_map.update_tile(tile_position, _reveal_tile)


func _reveal_tile(tile_data: TileData) -> void:
	tile_data.modulate = Color(1.0, 1.0, 1.0, 0.0)
