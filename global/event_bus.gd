extends Node
## EventBus
# This class serves as a global event bus for the game, allowing different parts of the game
# to communicate with each other through events.

# Senses-related events
signal sense_focus_changed(sense: Sense, variation: float)

# VisitorStats-related events
signal visitor_admitted(visitor_stats: VisitorStats)
signal visitor_denied(visitor_stats: VisitorStats)

signal next_day_started(day_number: int)


func _ready() -> void:
	sense_focus_changed.connect(_on_sense_focus_changed)
	visitor_admitted.connect(_on_visitor_admitted)
	visitor_denied.connect(_on_visitor_denied)
	next_day_started.connect(_on_next_day_started)


func _on_sense_focus_changed(sense: Sense, variation: float) -> void:
	print("Sense focus changed: %s by %2.1f" % [sense.id, variation])


func _on_visitor_admitted(visitor_stats: VisitorStats) -> void:
	print("Visitor admitted: %s" % visitor_stats.name)


func _on_visitor_denied(visitor_stats: VisitorStats) -> void:
	print("Visitor denied: %s" % visitor_stats.name)


func _on_next_day_started(day_number: int) -> void:
	print("Next day started: Day %d" % day_number)