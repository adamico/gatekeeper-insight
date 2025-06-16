extends GPUParticles2D

const PARTICLE_MATERIAL : ParticleProcessMaterial = preload("res://resources/sound_wave_particles.tres")


func _ready() -> void:
	finished.connect(set_process.bind(false))
	process_material = PARTICLE_MATERIAL.duplicate()
	process_material.initial_velocity_min = 192.0
	process_material.initial_velocity_max = 192.0
	_setup_parameters()
	restart()


func _setup_parameters() -> void:
	emitting = true
	one_shot = true
	amount = 16
