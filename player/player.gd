class_name Player
extends Node2D

const CELL_SIZE := 16

const ACTION_VECTORS = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_down": Vector2.DOWN,
	"move_up": Vector2.UP
}

var speed := 200

@onready var ray_cast_2d: RayCast2D = %RayCast2D
@onready var sonar_area: SonarArea = %SonarArea

func _unhandled_input(event: InputEvent) -> void:
	for action in ACTION_VECTORS.keys():
		if event.is_action_released(action):
			_move(action)

	if event.is_action_pressed("send_echo"):
		sonar_area.create_echo()



func _move(action: String) -> void:
	var target_position = ACTION_VECTORS[action] * CELL_SIZE
	ray_cast_2d.target_position = target_position
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		return

	position += target_position
