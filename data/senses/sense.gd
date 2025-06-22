class_name Sense extends Resource


@export var id: String
@export var name: String
@export_multiline var description: String
@export var texture: Texture2D

@export_category("Rank stats")
@export var focus_rank: float = 0.0
@export var max_focus_rank: float = 3.0


func get_focus_rank() -> float:
	return focus_rank
	

func is_focus_maxed() -> bool:
	return focus_rank >= max_focus_rank


func update_focus(variation: float) -> void:
	focus_rank += variation
	focus_rank = clamp(focus_rank, 0.0, max_focus_rank)

	EventBus.sense_focus_changed.emit(self, variation)
	print("[Sense] Focus for '%s' updated to %2.1f" % [id, focus_rank])
