extends Control

var gate_keeper: Node
var visitor: Node

@onready var allow: Node = %Allow
@onready var deny: Node = %Deny
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


func _ready() -> void:
	allow.pressed.connect(_on_admit_pressed)
	deny.pressed.connect(_on_deny_pressed)


func _on_admit_pressed() -> void:
	print("Allow button pressed.")
	audio_stream_player.play()
	visitor = get_tree().get_first_node_in_group("visitor")
	EventBus.visitor_admitted.emit(visitor.visitor_stats)


func _on_deny_pressed() -> void:
	audio_stream_player.play()
	print("Deny button pressed.")
	visitor = get_tree().get_first_node_in_group("visitor")
	EventBus.visitor_denied.emit(visitor.visitor_stats)
