class_name VisitorControl
extends Control

@export var visitor: Visitor : set = _set_visitor

var gate_keeper: GateKeeper

@onready var name_label: Label = %NameLabel
@onready var profile_label: Label = %ProfileLabel
@onready var texture_rect: TextureRect = %TextureRect


func _ready() -> void:
	gate_keeper = get_tree().get_first_node_in_group("gate_keeper")


func _set_visitor(value: Visitor) -> void:
	if not is_node_ready():
		await ready

	visitor = value
	name_label.text = visitor.name

	# set the profile name is the profile is known to the gate_keeper
	if gate_keeper and gate_keeper.is_profile_known(visitor.profile):
		profile_label.text = visitor.profile_name
	else:
		# if the profile is not known, set it to "Unknown"
		# this is to prevent the gate_keeper from knowing the profile
		# before the visitor is accepted for entry to the city
		profile_label.text = "Unknown"
	
	texture_rect.texture = visitor.texture
