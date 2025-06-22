## GateKeeper.gd
# This script manages the gatekeeper's functionality, including profile management and handling senses focus value.
# It extends Node2D and uses a GateKeeperStats resource to manage known visitor profiles.
# The gatekeeper can add visitor profiles and check if a profile is known.
class_name GateKeeper extends Node2D

const SCENE_CONTROL: PackedScene = preload("res://scenes/gate_keeper/senses/sense_control.tscn")

@export var gate_keeper_stats: GateKeeperStats

@onready var senses_root_container: Control = %SensesRootContainer
@onready var senses_container: Control = %SensesContainer


func _ready() -> void:
	senses_root_container.show()
	_setup_senses()
	EventBus.sense_focus_changed.connect(_on_sense_focus_changed)
   	# Initialize the gatekeeper
	print("GateKeeper is ready.")


func add_visitor_profile(profile_name: String) -> void:
	# delegate the addition to the gate_keeper's stats
	gate_keeper_stats.add_visitor_profile(profile_name)


func is_profile_known(profile_name: String) -> bool:
	# delegate the check to the gate_keeper's stats
	return gate_keeper_stats.is_profile_known(profile_name)


func get_senses() -> Array[Sense]:
	# delegate the retrieval of senses to the gate_keeper's stats
	return gate_keeper_stats.senses_list.senses


func _setup_senses() -> void:
	var senses = gate_keeper_stats.senses_list.senses
	for sense in senses:
		var sense_control: Control = SCENE_CONTROL.instantiate()
		sense_control.sense = sense
		senses_container.add_child(sense_control)
		print("[GateKeeper] Sense '%s' initialized with focus rank %2.1f" % [sense.id, sense.get_focus_rank()])


func _on_sense_focus_changed(_sense: Sense, variation: float) -> void:
	gate_keeper_stats.update_focus_pool(variation)
	print("[GateKeeper] Focus pool updated: %2.1f" % gate_keeper_stats._current_focus_pool)
