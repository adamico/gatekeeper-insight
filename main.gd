class_name Main
extends Node

const ENVIRONMENT_COLOR := Color(0.05, 0.0, 0.1, 1)

@onready var tilemap : TileMapLayer = %Tilemap


func _ready() -> void:
	RenderingServer.set_default_clear_color(ENVIRONMENT_COLOR)
