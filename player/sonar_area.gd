class_name SonarArea
extends Area2D

@export var min_radius := 16.0
@export var max_radius := min_radius * 8
@export var radius_step := 16.0

var _current_radius:= min_radius

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sonar_graphics: Node2D = %SonarGraphics
@onready var sonar_animation_player: AnimationPlayer = %SonarAnimationPlayer

func _ready() -> void:
	body_shape_entered.connect(_on_body_shape_entered)


func create_echo() -> void:
	sonar_graphics.show()
	sonar_animation_player.play("echo")
	await sonar_animation_player.animation_finished
	sonar_graphics.hide()


func old_create_echo(delta: float) -> void:
	var circle: CircleShape2D = collision_shape_2d.shape
	_current_radius += radius_step * delta
	if _current_radius > max_radius:
		radius_step = -radius_step

	if _current_radius < min_radius:
		return

	sonar_graphics.show()
	circle.radius = _current_radius


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
