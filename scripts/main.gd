class_name Main
extends Node

const ENVIRONMENT_COLOR := Color8(87, 51, 47, 255)

@onready var tilemap : TileMapLayer = %Tilemap


func _ready() -> void:
	RenderingServer.set_default_clear_color(ENVIRONMENT_COLOR)
