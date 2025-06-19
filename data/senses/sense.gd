class_name Sense
extends Resource


@export var id: String
@export var name: String
@export_multiline var description: String
@export var texture: Texture2D


func use() -> void:
    # This method can be overridden by subclasses to define specific behavior when the sense is used.
    print("Using sense: %s" % name)
    EventBus.sense_used.emit(self)
    