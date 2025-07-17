extends Node2D

@onready var current_scene = $CurrentScene
@onready var cutscene_layer = $CutsceneLayer
@onready var fade = $FadeRect

func _ready() -> void:
	fade_in()
	var pos_inicial = Vector2(159, 110)

	#tocar_cutscene("res://Cutscenes/Scenes/cutscene_sonho_estelar.tscn")
	trocar_cena_do_jogo("res://Lugares/Scenes/cabana.tscn", pos_inicial)


func trocar_cena_do_jogo(path: String, destino: Vector2 = Vector2.ZERO) -> void:
	if current_scene.get_child_count() > 0:
		current_scene.get_child(0).queue_free()
		
	var cena = load(path).instantiate()
	current_scene.add_child(cena)
	
	await get_tree().process_frame
	
	var ysort = cena.get_node("YSort")
	var character = load("res://Character/Scenes/character.tscn").instantiate()
	ysort.add_child(character)
	
	if destino != Vector2.ZERO:
		character.global_position = destino
	else:
		character.global_position = GlobalState.player_position

	# Atualiza a posição no estado
	GlobalState.player_position = character.global_position
	
func tocar_cutscene(path: String) -> void:
	var cutscene = load(path).instantiate()
	cutscene_layer.add_child(cutscene)

func fade_in() -> void:
	fade.visible = true
	fade.modulate.a = 1.0
	fade.create_tween().tween_property(fade, "modulate:a", 0.0, 1.0)
	
func fade_out() -> void:
	fade.visible = true
	fade.modulate.a = 0.0
	fade.create_tween().tween_property(fade, "modulate:a", 1.0, 1.0)
