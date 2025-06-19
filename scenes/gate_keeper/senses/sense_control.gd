@tool

class_name SenseControl
extends Control


@export var sense: Sense : set = _set_sense

@onready var button: Button = $VBoxContainer/Button
@onready var label: Label = $VBoxContainer/Label


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		use()


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
