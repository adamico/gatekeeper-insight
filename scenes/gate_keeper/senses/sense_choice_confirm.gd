class_name SenseChoiceConfirm extends Control

var sense: Sense


@onready var confirm: Button = %Confirm
@onready var cancel: Button = %Cancel


func _ready() -> void:
	confirm.pressed.connect(_on_confirm_pressed)
	cancel.pressed.connect(_on_cancel_pressed)


func _on_confirm_pressed() -> void:
	if not sense:
		return

	EventBus.sense_used.emit(sense.id)
	hide()


func _on_cancel_pressed() -> void:
	EventBus.sense_choice_cancel.emit()
	hide()