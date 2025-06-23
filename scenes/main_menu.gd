extends Control

@onready var play_button: Button = %PlayButton
@onready var credits_button: Button = %CreditsButton
@onready var quit_button: Button = %QuitButton

@onready var credits: Node = %Credits
@onready var intro: Node = %Intro

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	quit_button.pressed.connect(get_tree().quit)
	print("Main Menu is ready.")


func _on_credits_button_pressed() -> void:
	audio_stream_player.play()
	print("Credits button pressed. Changing to Credits scene...")
	credits.show()

func _on_play_button_pressed() -> void:
	audio_stream_player.play()
	print("Play button pressed. Showing the intro screen...")
	intro.show()
