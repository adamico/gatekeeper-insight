class_name  Senses extends Node2D


@onready var sense_choice_confirm = %SenseChoiceConfirm


func _ready() -> void:
	sense_choice_confirm.hide()
	# Initialize the senses
	print("Senses are ready.")
