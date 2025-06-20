## GateKeeper.gd
# This script manages the gatekeeper's functionality, including profile management and handling senses focus value.
# It extends Node2D and uses a GateKeeperStats resource to manage known visitor profiles.
# The gatekeeper can add visitor profiles and check if a profile is known.
class_name GateKeeper extends Node2D

@export var gate_keeper_stats: GateKeeperStats

@onready var senses: Node2D = %Senses


func _ready() -> void:
	senses.show()

	EventBus.sense_used.connect(_on_sense_used)
   	# Initialize the gatekeeper
	print("GateKeeper is ready.")


func add_visitor_profile(profile_name: String) -> void:
	# delegate the addition to the gate_keeper's stats
	gate_keeper_stats.add_visitor_profile(profile_name)


func is_profile_known(profile_name: String) -> bool:
	# delegate the check to the gate_keeper's stats
	return gate_keeper_stats.is_profile_known(profile_name)


func get_focus_rank(sense_name: String) -> int:
	# delegate the focus rank retrieval to the gate_keeper's stats
	return gate_keeper_stats.get_focus_rank(sense_name)


func _on_sense_used(sense_name: String) -> void:
	print("[GateKeeper]Sense used: %s" % sense_name)
	gate_keeper_stats.update_focus_rank(sense_name)
