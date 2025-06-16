class_name Gun
extends Sprite2D

const SHOOT_SOUND: AudioStreamOggVorbis = preload("res://assets/sounds/laser4.ogg")

@onready var audio_player: AudioStreamPlayer2D = %AudioStreamPlayer2D
@onready var raycast_2d: RayCast2D = %RayCast2D
@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D


func _process(_delta: float) -> void:
	_update_visuals()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("send_hf_echo"):
		_shoot()


func _shoot() -> void:
	gpu_particles_2d.emitting = true

	if has_method("_play_shoot_sound"):
		_play_shoot_sound()


func _update_visuals() -> void:
	var minimum_update_distance := 24.0
	var mouse_position := get_global_mouse_position()
	var distance_to_mouse := global_position.distance_to(mouse_position)
	if distance_to_mouse <= minimum_update_distance:
		return

	var direction := global_position.direction_to(mouse_position).normalized()
	var angle := direction.angle()

	var scale_factor = 1.0 if (angle > -PI/2 and angle < PI/2) else -1.0
	scale = Vector2(1.0, scale_factor)

	position = direction.normalized() * 20
	rotation = angle


func _play_shoot_sound() -> void:
	audio_player.stream = SHOOT_SOUND
	audio_player.play()
