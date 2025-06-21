class_name  Senses extends Node2D


@onready var sense_choice_confirm = %SenseChoiceConfirm


func _ready() -> void:
	sense_choice_confirm.hide()

	EventBus.sense_used.connect(_on_sense_used)
	# Initialize the senses
	print("Senses are ready.")


func _on_sense_used(sense_id: String) -> void:
	if not is_instance_valid(sense_choice_confirm):
		return

	sense_choice_confirm.show()
	#sense_choice_confirm.sense_id = sense_id
	#sense_choice_confirm.popup_centered()
	print("Sense used:", sense_id)
