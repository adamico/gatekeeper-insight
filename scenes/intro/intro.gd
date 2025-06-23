extends CenterContainer

const GAME_SCENE := preload("res://scenes/game/game.tscn")

@onready var start_button: Button = %StartButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	print("Intro scene is ready.")


func _on_start_button_pressed() -> void:
	print("Start button pressed. Changing to the game scene...")
	get_tree().change_scene_to_packed(GAME_SCENE)