extends Control

@onready var back_button: Button = %BackButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)
	print("Credits scene is ready.")


func _on_back_button_pressed() -> void:
	audio_stream_player.play()
	print("Back button pressed. Returning to Main Menu...")
	hide()