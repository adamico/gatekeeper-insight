extends Control

var gate_keeper: Node
var visitor: Node

@onready var allow: Node = %Allow
@onready var deny: Node = %Deny


func _ready() -> void:
	gate_keeper = get_tree().get_first_node_in_group("gate_keeper")
	allow.pressed.connect(_on_admit_pressed)
	deny.pressed.connect(_on_deny_pressed)


func _on_admit_pressed() -> void:
	print("Allow button pressed.")
	visitor = get_tree().get_first_node_in_group("visitor")
	EventBus.visitor_admitted.emit(visitor.visitor_stats)


func _on_deny_pressed() -> void:
	print("Deny button pressed.")
	visitor = get_tree().get_first_node_in_group("visitor")
	EventBus.visitor_denied.emit(visitor.visitor_stats)
