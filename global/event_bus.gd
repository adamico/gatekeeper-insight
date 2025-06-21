extends Node
## EventBus
# This class serves as a global event bus for the game, allowing different parts of the game
# to communicate with each other through events.

# Senses-related events
signal sense_used(sense_id: String)
signal sense_button_pressed(sense_control: Node)
signal sense_choice_cancel

const SENSE_CHOIX_CONFIRM = preload("res://scenes/gate_keeper/senses/sense_choice_confirm.tscn")

var sense_choice_confirm : Node


func _ready() -> void:
	sense_used.connect(_on_sense_used)
	sense_button_pressed.connect(_on_sense_button_pressed)
	sense_choice_confirm = SENSE_CHOIX_CONFIRM.instantiate()
	sense_choice_cancel.connect(_on_sense_cancel_pressed)


func _on_sense_used(_sense_id: String) -> void:
	_reset_senses_nodes()


func _on_sense_button_pressed(sense_control: Node) -> void:
	sense_choice_confirm.sense = sense_control.sense
	sense_control.add_child(sense_choice_confirm)
	sense_choice_confirm.show()
	_disable_other_senses(sense_control)


func _on_sense_cancel_pressed() -> void:
	_reset_senses_nodes()


func _reset_senses_nodes() -> void:
	sense_choice_confirm.get_parent().remove_child(sense_choice_confirm)
	sense_choice_confirm.hide()
	_enable_senses()


func _disable_other_senses(sense_control: Node) -> void:
	for sense_node : Node in get_tree().get_nodes_in_group("senses"):
		if sense_node is not SenseControl:
			continue

		if sense_node == sense_control:
			continue

		sense_node.button.disabled = true
		sense_node.button.pressed.disconnect(sense_node.on_button_pressed)


func _enable_senses() -> void:
	for sense_node in get_tree().get_nodes_in_group("senses"):
		if sense_node is not SenseControl:
			continue

		sense_node.button.disabled = false

		if sense_node.button.pressed.is_connected(sense_node.on_button_pressed):
			continue

		sense_node.button.pressed.connect(sense_node.on_button_pressed)
