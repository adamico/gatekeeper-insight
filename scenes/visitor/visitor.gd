class_name Visitor extends Control

@export var visitor_stats: VisitorStats : set = _set_visitor_stats

var gate_keeper: GateKeeper

@onready var senses_stats: Dictionary
@onready var name_label: Label = %NameLabel
@onready var profile_label: RichTextLabel = %ProfileLabel
@onready var texture_rect: TextureRect = %TextureRect


func _ready() -> void:
	gate_keeper = get_tree().get_first_node_in_group("gate_keeper")
	EventBus.sense_used.connect(_update_single_stat_ui)
	EventBus.visitor_admitted.connect(queue_free.unbind(1))
	EventBus.visitor_denied.connect(queue_free.unbind(1))


func _set_visitor_stats(value: VisitorStats) -> void:
	if not is_node_ready():
		await ready

	visitor_stats = value
	senses_stats = visitor_stats.get_stats()
	_set_profile_name()
	_update_stats_ui()


func _set_profile_name() -> void:
	var profile_name: String = visitor_stats.get_profile_name()
	var is_known_profile = gate_keeper.is_profile_known(profile_name)
	var profile_type: int = visitor_stats.get_profile_type()
	var profile_label_text: String
	if profile_type == VisitorStats.ProfileType.SAFE:
		profile_label_text = _safe_text(profile_name)
	elif profile_type == VisitorStats.ProfileType.DANGEROUS:
		profile_label_text = _danger_text(profile_name)
	else:
		profile_label_text = "???"
	profile_label.text = profile_label_text if gate_keeper and is_known_profile else "???"

	var visitor_name: String = visitor_stats.get_true_name() if is_known_profile else visitor_stats.name
	name_label.text = visitor_name

	texture_rect.texture = visitor_stats.texture


func _safe_text(text: String) -> String:
	return "[color=green]%s[/color]" % text


func _danger_text(text: String) -> String:
	return "[color=red]%s[/color]" % text


func _update_stats_ui() -> void:
	senses_stats.keys().map(_update_single_stat_ui)


func _update_single_stat_ui(sense_id: String) -> void:
	var sense_value_label: Label = get_node("%%%s" % sense_id.capitalize())
	var focus_rank: int = gate_keeper.get_focus_rank(sense_id)

	if not sense_value_label:
		return

	var sense_text_fragments: Array[String]
	for i in range(focus_rank + 1):
		# Get the sense value based on the focus rank
		# if the focus rank exceeds the available stats don't append anything
		if i >= senses_stats[sense_id].size():
			break
		var sense_text: String = str(senses_stats[sense_id][i])
		sense_text_fragments.append(sense_text)

	sense_value_label.text = ", ".join(sense_text_fragments)
