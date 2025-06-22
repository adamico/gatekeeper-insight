extends Control

@onready var day_value: Label = %DayValue
@onready var remaining_visitors_value: Label = %RemainingVisitorsValue
@onready var accepted_value: Label = %AcceptedValue
@onready var denied_value: Label = %DeniedValue


func _ready() -> void:
	EventBus.visitor_admitted.connect(_on_visitor_admitted)
	EventBus.visitor_denied.connect(_on_visitor_denied)

	_update_ui()


func _update_ui() -> void:
	day_value.text = str(GameStats.current_day)
	remaining_visitors_value.text = str(GameStats.remaining_visitors)
	accepted_value.text = str(GameStats.admitted_count)
	denied_value.text = str(GameStats.denied_count)


func _on_visitor_admitted(visitor_stats: VisitorStats) -> void:
	print("Visitor admitted: %s" % visitor_stats.get_profile_name())
	_update_ui()


func _on_visitor_denied(visitor_stats: VisitorStats) -> void:
	print("Visitor denied: %s" % visitor_stats.get_profile_name())
	_update_ui()
