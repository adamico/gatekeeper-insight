class_name SenseControl extends Control



@export var sense: Sense : set = _set_sense

@onready var button: Button = %Button
@onready var label: Label = %Label


func _ready() -> void:
	button.pressed.connect(on_button_pressed)
	button.mouse_entered.connect(_on_mouse_entered)
	button.mouse_exited.connect(_on_mouse_exited)


func on_button_pressed() -> void:
	if not sense:
		return
	EventBus.sense_button_pressed.emit(self)


func _on_mouse_entered() -> void:
	label.show()


func _on_mouse_exited() -> void:
	label.hide()


func _set_sense(value: Sense) -> void:
	if not is_node_ready():
		await ready

	sense = value
	label.text = sense.name
	button.icon = sense.texture
