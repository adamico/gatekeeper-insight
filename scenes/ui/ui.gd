extends Control

var gate_keeper: Node
var visitor: Node

@onready var admit: Node = %Admit
@onready var deny: Node = %Deny 


func _ready() -> void:
	gate_keeper = get_tree().get_first_node_in_group("gate_keeper")
	visitor = get_tree().get_first_node_in_group("visitor")
	admit.pressed.connect(_on_admit_pressed)
	deny.pressed.connect(_on_deny_pressed)


func _on_admit_pressed() -> void:
	print("Admit button pressed.")
	EventBus.visitor_admitted.emit(visitor)


func _on_deny_pressed() -> void:
	print("Deny button pressed.")
	EventBus.visitor_denied.emit(visitor)
