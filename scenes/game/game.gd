class_name Main extends Node

const ACTIONS_CONTAINER = preload("res://scenes/ui/actions_container.tscn")

const GATE_KEEPER = preload("res://scenes/gate_keeper/gate_keeper.tscn")
const VISITOR = preload("res://scenes/visitor/visitor_container.tscn")
const VISITOR_STATS: Array[VisitorStats] = [
	preload("res://data/visitors/citizen.tres"),
	preload("res://data/visitors/merchant.tres"),
	preload("res://data/visitors/noble.tres"),
	preload("res://data/visitors/smuggler.tres"),
	preload("res://data/visitors/vampire.tres"),
]

@export var gate_keeper_stats: GateKeeperStats

var gate_keeper: Node
var visitor: Node

@onready var gate_keeper_position: Marker2D = %GateKeeperPosition
@onready var visitor_position: Marker2D = %VisitorPosition
@onready var actions_position: Marker2D = %ActionsPosition
@onready var day_end: Node = %DayEnd


func _ready() -> void:
	_start()
	EventBus.visitor_admitted.connect(_new_visitor.unbind(1))
	EventBus.visitor_denied.connect(_new_visitor.unbind(1))
	GameStats.day_completed.connect(_on_day_completed)
	EventBus.next_day_started.connect(_on_next_day_started)

	print("Main scene is ready.")


func _start() -> void:
	_initialize_gate_keeper()
	_new_visitor()
	_attach_ui()


func _attach_ui() -> void:
	var ui = ACTIONS_CONTAINER.instantiate()
	actions_position.add_child(ui)
	print("ACTIONS_CONTAINER attached to the main scene.")


func _initialize_gate_keeper() -> void:
	gate_keeper = GATE_KEEPER.instantiate()
	gate_keeper.gate_keeper_stats = gate_keeper_stats.create_instance()
	gate_keeper_position.add_child(gate_keeper)


func _new_visitor() -> void:
	visitor = VISITOR.instantiate()
	var random_visitor_stats = VISITOR_STATS.pick_random().create_instance()
	visitor.visitor_stats = random_visitor_stats
	visitor_position.add_child(visitor)

func _on_day_completed(_day_number: int, _score: float, _rating: String) -> void:
	day_end.show()


func _on_next_day_started(day_number: int) -> void:
	print("Next day started: Day %d" % day_number)
	day_end.hide()

