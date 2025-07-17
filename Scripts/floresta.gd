extends Node2D

const SLIME_SCENE = preload("res://Scenes/slime.tscn")
@onready var quest_slimes_spawns = $QuestSlimeSpawns

func _ready() -> void:
	spawn_quest_slimes()

func spawn_quest_slimes() -> void:
	if WorldState.is_quest_complete("kill_slimes"):
		return
	for spawn_point in quest_slimes_spawns.get_children():
		var slime_id = spawn_point.name
		
		if WorldState.is_entity_alive(slime_id):
			var slime = SLIME_SCENE.instantiate() as Slime
			slime.unique_id = slime_id
			slime.position = spawn_point.position
			add_child(slime)

func _process(_delta: float) -> void:
	pass
