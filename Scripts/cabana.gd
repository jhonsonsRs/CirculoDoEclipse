extends Node2D

@onready var book_spawn: Marker2D = $BookSpawn
@onready var lantern_spawn: Marker2D = $LanternSpawn
@onready var lantern_scene := preload("res://Scenes/lanterna.tscn")
@onready var character: Character = get_tree().get_first_node_in_group("character")
@onready var limit_tl = $CameraLimit_TopLeft
@onready var limit_br = $CameraLimit_BottomRight
@onready var player_camera: Camera2D = get_tree().get_first_node_in_group("character").get_node("Camera2D")

func _ready() -> void:
	spawn_lantern()
	if player_camera:
		player_camera.set_camera_limit(limit_tl.global_position, limit_br.global_position)
	#var lanterna = $Components/Lanterna/Area2D as Lantern_interactable
	#var character = get_tree().get_first_node_in_group("character") as Character
	#lanterna.connect("lanterna_coletada", Callable(character, "_on_lanterna_coletada"))

func spawn_lantern() -> void:
	if WorldState.is_active("lantern_cabana"):
		var lanterna: Lantern_interactable = lantern_scene.instantiate()
		lanterna.position = lantern_spawn.position
		add_child(lanterna)
		
		lanterna.connect("lanterna_coletada", Callable(character, "_on_lanterna_coletada"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
