extends Node
## EventBus
# This class serves as a global event bus for the game, allowing different parts of the game
# to communicate with each other through events.

# Senses-related events
signal sense_used(sense_id: String)
signal sense_button_pressed(sense_control: Node)
signal sense_choice_cancel

# VisitorStats-related events
signal visitor_admitted(visitor: Node)
signal visitor_denied(visitor: Node)


const SENSE_CHOIX_CONFIRM = preload("res://scenes/gate_keeper/senses/sense_choice_confirm.tscn")

var sense_choice_confirm : Node


func _ready() -> void:
	sense_used.connect(_on_sense_used)
	sense_button_pressed.connect(_on_sense_button_pressed)
	sense_choice_confirm = SENSE_CHOIX_CONFIRM.instantiate()
	sense_choice_cancel.connect(_on_sense_cancel_pressed)
	visitor_admitted.connect(_on_visitor_admitted)
	visitor_denied.connect(_on_visitor_denied)


func _on_sense_used(_sense_id: String) -> void:
	_reset_senses_nodes()


func _on_sense_button_pressed(sense_control: Node) -> void:
	var sense_choice_confirm_parent = sense_choice_confirm.get_parent()
	if sense_choice_confirm_parent:
		sense_choice_confirm_parent.remove_child(sense_choice_confirm)
	sense_choice_confirm.sense = sense_control.sense
	sense_control.add_child(sense_choice_confirm)
	sense_choice_confirm.show()


func _on_sense_cancel_pressed() -> void:
	_reset_senses_nodes()


func _on_visitor_admitted(visitor: Node) -> void:
	print("VisitorStats admitted: %s" % visitor.name)


func _on_visitor_denied(visitor: Node) -> void:
	print("VisitorStats denied: %s" % visitor.name)

# Resets the sense choice confirm node by removing it from its parent and hiding it.
func _reset_senses_nodes() -> void:
	sense_choice_confirm.get_parent().remove_child(sense_choice_confirm)
	sense_choice_confirm.hide()
