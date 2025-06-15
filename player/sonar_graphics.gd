@tool

extends Node2D

const SONAR_COLOR := Color.AQUA

var min_sonar_radius := 10.0
var max_sonar_radius : float
var current_sonar_radius: float

@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func _process(_delta: float) -> void:
	current_sonar_radius = collision_shape_2d.shape.radius
	queue_redraw()


func _draw() -> void:
	draw_circle(position, current_sonar_radius, SONAR_COLOR, false, 1.0)
