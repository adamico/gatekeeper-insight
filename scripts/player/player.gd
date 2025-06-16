class_name Player
extends CharacterBody2D

var base_speed := 10.0
var max_speed := 80.0
var acceleration := 8
var friction := 10
var input_vector := Vector2.ZERO

@onready var sonar_area: SonarArea = %SonarArea
@onready var gun_node: Gun = %Gun


func _process(_delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if input_vector == Vector2.ZERO:
		_decelerate()
	else:
		_accelerate()
	move_and_slide()


func _decelerate() -> void:
	velocity = velocity.move_toward(Vector2.ZERO, friction)


func _accelerate() -> void:
	velocity = velocity.move_toward(input_vector * max_speed, acceleration)
