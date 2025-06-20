@tool
class_name SenseControl extends Control


@export var sense: Sense : set = _set_sense

@onready var button: Button = %Button
@onready var label: Label = %Label


func _ready() -> void:
	button.pressed.connect(use)


func use() -> void:
	if not sense:
		return

	sense.use()


func _set_sense(value: Sense) -> void:
	if not is_node_ready():
		await ready

	sense = value
	label.text = sense.name
	button.icon = sense.texture
