class_name SonarArea
extends Area2D

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sonar_graphics: Node2D = %SonarGraphics
@onready var sonar_animation_player: AnimationPlayer = %SonarAnimationPlayer


func _ready() -> void:
	body_shape_entered.connect(_on_body_shape_entered)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("send_echo"):
		_create_echo()
	

func _create_echo() -> void:
	sonar_graphics.show()
	sonar_animation_player.play("echo")
	await sonar_animation_player.animation_finished
	sonar_graphics.hide()


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
