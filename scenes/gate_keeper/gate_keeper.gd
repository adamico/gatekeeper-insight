## GateKeeper.gd
# This script manages the gatekeeper's functionality, including profile management and handling senses focus value.
# It extends Node2D and uses a GateKeeperStats resource to manage known visitor profiles.
# The gatekeeper can add visitor profiles and check if a profile is known.
class_name GateKeeper extends Node2D

const SCENE_CONTROL: PackedScene = preload("res://scenes/gate_keeper/senses/sense_control.tscn")

@export var gate_keeper_stats: GateKeeperStats

@onready var senses_root_container: Control = %SensesRootContainer
@onready var senses_container: Control = %SensesContainer
@onready var focus_pool_label: Label = %FocusPoolValue

func _ready() -> void:
	senses_root_container.show()
	_setup_senses()
	_update_focus_pool_label()
	EventBus.sense_focus_changed.connect(_on_sense_focus_changed)
	EventBus.visitor_admitted.connect(_on_visitor_admitted)
	EventBus.visitor_denied.connect(_on_visitor_denied)
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
		senses_container.add_child(sense_control)
		sense_control.sense = sense
		print("[GateKeeper] Sense '%s' initialized with focus rank %2.1f" % [sense.id, sense.get_focus_rank()])


func _update_focus_pool_label() -> void:
	focus_pool_label.text = str(int(gate_keeper_stats.get_current_focus_pool()))


func _check_and_add_profile(visitor_stats: VisitorStats) -> void:
	var senses = gate_keeper_stats.senses_list.senses
	var total_senses_count = senses.size()
	var sufficient_focus_count = 0
	
	# Compare each sense focus rank with visitor's corresponding stat
	for sense in senses:
		var visitor_sense_value = visitor_stats.get_sense_value(sense.id)
		if sense.get_focus_rank() + 1 >= visitor_sense_value:
			sufficient_focus_count += 1.0
	
	print("[GateKeeper] Sufficient focus count: %d out of %d" % [sufficient_focus_count, total_senses_count])
	# Check if majority of senses have sufficient focus
	if sufficient_focus_count > total_senses_count / 2.0:
		gate_keeper_stats.add_visitor_profile(visitor_stats.get_profile_name())
		print("[GateKeeper] Added profile '%s' to known profiles" % visitor_stats.get_profile_name())


func _on_visitor_admitted(visitor_stats: VisitorStats) -> void:
	_check_and_add_profile(visitor_stats)
	gate_keeper_stats.update_focus_pool(-1.0)
	_update_focus_pool_label()
	print("Visitor admitted: %s" % visitor_stats.get_profile_name())


func _on_visitor_denied(visitor_stats: VisitorStats) -> void:
	gate_keeper_stats.update_focus_pool(-1.0)
	_update_focus_pool_label()
	print("Visitor denied: %s" % visitor_stats.get_profile_name())


func _on_sense_focus_changed(_sense: Sense, variation: float) -> void:
	if variation < 0.0:
		return  # Ignore sense focus decrease events

	gate_keeper_stats.update_focus_pool(variation)
	_update_focus_pool_label()
	print("[GateKeeper] Focus pool updated: %2.1f" % gate_keeper_stats._current_focus_pool)
