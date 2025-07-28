extends Node2D

const CORRUPTED_CRYSTAL_SCENE = preload("res://Scenes/corrupted_crystal.tscn")
@onready var quest_corrupted_crystal_spawns = $SpawnCrystalQuest
@onready var limit_tl = $CameraLimit_TopLeft
@onready var limit_br = $CameraLimit_BottomRight
@onready var player_camera: Camera2D = get_tree().get_first_node_in_group("character").get_node("Camera2D")

func _ready() -> void:
	spawn_corrupted_crystal()
	if player_camera:
		player_camera.set_camera_limit(limit_tl.global_position, limit_br.global_position)

func spawn_corrupted_crystal() -> void:
	for spawn_point in quest_corrupted_crystal_spawns.get_children():
		var corrupted_crystal_id = spawn_point.name
		
		# Verifica no WorldState se o cristal com esta ID específica já foi coletado
		if WorldState.is_active(corrupted_crystal_id):
			var corrupted_crystal = CORRUPTED_CRYSTAL_SCENE.instantiate() as Corrupted_Crystal
			
			# Define a ID única do cristal instanciado com o nome do Marker2D
			corrupted_crystal.unique_id = corrupted_crystal_id
			
			corrupted_crystal.position = spawn_point.position
			$YSort.add_child(corrupted_crystal)
