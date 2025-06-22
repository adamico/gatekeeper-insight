class_name SenseControl extends Control

@export var sense: Sense : set = _set_sense

@onready var sense_texture_rect: TextureRect = %SenseTextureRect
@onready var focus_increase_button: Button = %FocusIncreaseButton
@onready var focus_decrease_button: Button = %FocusDecreaseButton
@onready var focus_value_label: Label = %FocusValueLabel
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

func _ready() -> void:
	focus_increase_button.pressed.connect(_on_focus_change_pressed.bind(1.0))
	focus_decrease_button.pressed.connect(_on_focus_change_pressed.bind(-1.0))


func _on_focus_change_pressed(variation: float) -> void:
	if not sense:
		return
	audio_stream_player.play()
	sense.update_focus(variation)
	_update_focus_ui()


func _set_buttons(focus_value: float) -> void:
	focus_decrease_button.disabled = focus_value <= 0.0
	focus_increase_button.disabled = sense.is_focus_maxed()


func _update_focus_value_label(focus_value: float) -> void:
	print("[SenseControl] Updating focus value label for '%s': %2.1f" % [sense.id, focus_value])
	focus_value_label.text = str(int(focus_value)) if focus_value < sense.max_focus_rank else "MAX"


func _update_focus_ui() -> void:
	var focus_value: float = sense.get_focus_rank()
	_set_buttons(focus_value)
	_update_focus_value_label(focus_value)


func _set_sense(value: Sense) -> void:
	if not is_node_ready():
		await ready

	sense = value
	_update_focus_ui()
	sense_texture_rect.texture = sense.texture
