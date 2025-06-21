class_name Main extends Node

const GATE_KEEPER = preload("res://scenes/gate_keeper/gate_keeper.tscn")
const VISITOR = preload("res://scenes/visitor/visitor.tscn")
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


func _ready() -> void:
	_start()
	print("Main scene is ready.")


func _start() -> void:
	_initialize_gate_keeper()
	_new_visitor()


func _initialize_gate_keeper() -> void:
	gate_keeper = GATE_KEEPER.instantiate()
	gate_keeper.gate_keeper_stats = gate_keeper_stats.create_instance()
	gate_keeper_position.add_child(gate_keeper)


func _new_visitor() -> void:
	visitor = VISITOR.instantiate()
	var random_visitor_stats = VISITOR_STATS.pick_random()
	visitor.visitor_stats = random_visitor_stats.create_instance()
	visitor_position.add_child(visitor)
