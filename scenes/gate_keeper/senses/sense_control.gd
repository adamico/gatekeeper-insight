class_name SenseControl extends Control

@export var sense: Sense : set = _set_sense

var focus_value: float

@onready var sense_texture_rect: TextureRect = %SenseTextureRect
@onready var focus_increase_button: Button = %FocusIncreaseButton
@onready var focus_decrease_button: Button = %FocusDecreaseButton
@onready var focus_value_label: Label = %FocusValueLabel


func _ready() -> void:
	focus_increase_button.pressed.connect(_on_focus_change_pressed.bind(1.0))
	focus_decrease_button.pressed.connect(_on_focus_change_pressed.bind(-1.0))



func _on_focus_change_pressed(variation: float) -> void:
	if not sense:
		return
	sense.update_focus(variation)
	_try_disable_buttons()
	_update_focus_value_label()


func _try_disable_buttons() -> void:
	if not sense:
		return
	focus_value = sense.get_focus_rank()
	focus_decrease_button.disabled = focus_value <= 0.0
	focus_increase_button.disabled = sense.is_focus_maxed()


func _update_focus_value_label() -> void:
	focus_value_label.text = str(int(focus_value)) if focus_value < sense.max_focus_rank else "MAX"


func _set_sense(value: Sense) -> void:
	if not is_node_ready():
		await ready

	sense = value
	_try_disable_buttons()
	_update_focus_value_label()
	sense_texture_rect.texture = sense.texture
