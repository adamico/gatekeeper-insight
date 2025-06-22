class_name SenseStat extends Resource

var id: String
var stat_details: Array[String]


func _init(new_id: String, new_stat_details: Array[String]) -> void:
	id = new_id
	stat_details = new_stat_details