class_name Sense extends Resource


@export var id: String
@export var name: String
@export_multiline var description: String
@export var texture: Texture2D




func use() -> void:
	EventBus.sense_used.emit(id)
