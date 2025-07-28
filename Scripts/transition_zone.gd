extends Area2D
class_name TransitionZone

@export var zone_id: String = ""
@export var target_map_name: String = ""
@export var target_marker_name: String = "PlayerSpawn"
@onready var game = get_tree().get_first_node_in_group("game")

func on_body_entered(_body)-> void:
		if _body is Character:
			if not zone_id.is_empty():
				game.on_zone_entered(zone_id)
				
			if not target_map_name.is_empty():
				game.call_deferred("change_map", target_map_name, target_marker_name)
