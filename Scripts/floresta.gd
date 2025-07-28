extends Node2D

const SLIME_SCENE = preload("res://Scenes/slime.tscn")
@onready var quest_slimes_spawns = $QuestSlimeSpawns
@onready var limit_tl = $CameraLimit_TopLeft
@onready var limit_br = $CameraLimit_BottomRight
@onready var player_camera: Camera2D = get_tree().get_first_node_in_group("character").get_node("Camera2D")


func _ready() -> void:
	if player_camera:
		player_camera.set_camera_limit(limit_tl.global_position, limit_br.global_position)

func _process(_delta: float) -> void:
	pass
