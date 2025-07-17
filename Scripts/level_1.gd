extends Node2D

func _ready() -> void:
	var lanterna = $Components/Lanterna/Area2D as Lantern_interactable
	var character = $YSort/Character as Character
	lanterna.connect("lanterna_coletada", Callable(character, "_on_lanterna_coletada"))
	
	var slime_scene = preload("res://Character/Scenes/slime.tscn")
	var spawn_points = [
		Vector2(1282, -265),
		Vector2(1413, -261),
		Vector2(1305, -188),
		Vector2(1406, -176)
	]

	for point in spawn_points:
		var slime = slime_scene.instantiate()
		slime.position = point
		add_child(slime)
		
func _process(_delta) -> void:
	pass
