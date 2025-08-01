extends Node2D
#É o diretor do jogo

const MAPS_SCENES := {
	"cabana": preload("res://Scenes/cabana.tscn"),
	"floresta": preload("res://Scenes/floresta.tscn"),
	"casa_alquimista": preload("res://Scenes/casa_alquimista.tscn"),
	"distorted_forest": preload("res://Scenes/distorted_forest.tscn")
}

@onready var character: CharacterBody2D = $Character
@onready var current_map: Node2D = $CurrentMap
@onready var cutscene_layer = $CutsceneLayer
@onready var camera := $Character/Camera2D

var questManager = QuestManager
var current_map_name: String = ""
var current_map_node: Node2D = null

func _ready() -> void:
	change_map("cabana")

#aqui ele gerencia o cenário, essa função decide qual mapa vai ser carregado
func change_map(map_name: String, entry_marker: String = "PlayerSpawn"):
	if map_name == current_map_name:
		return

	var previous_map_name = current_map_name

	if current_map_node:
		current_map_node.queue_free()
		current_map_node = null
		
	var scene: PackedScene = MAPS_SCENES.get(map_name)
	if scene == null:
		push_error("Mapa não encontrado: %s" % map_name)
		return
		
	current_map_node = scene.instantiate()
	current_map.add_child(current_map_node)
	current_map_name = map_name

	var spawn := current_map_node.get_node_or_null(entry_marker)
	if spawn:
		character.global_position = spawn.global_position

	# Dispara o evento de troca de mapa no final.
	on_map_changed(previous_map_name, current_map_name)

func on_map_changed(previous_map: String, new_map: String) -> void:
	# Se for o primeiro mapa a ser carregado, não faz nada.
	if previous_map.is_empty():
		return

	# Verifica se há uma missão ativa e se ela tem o método "on_map_changed" antes de chamá-lo.
	if QuestManager.current_quest and QuestManager.current_quest.has_method("on_map_changed"):
		QuestManager.current_quest.on_map_changed(previous_map, new_map)

func on_dialogue_finished(npc_id: String) -> void:
	if QuestManager.current_quest and QuestManager.current_quest.has_method("on_dialogue_finished"):
		QuestManager.current_quest.on_dialogue_finished(npc_id)

func on_zone_entered(zone_id: String) -> void:
	if QuestManager.current_quest and QuestManager.current_quest.has_method("on_zone_entered"):
		QuestManager.current_quest.on_zone_entered(zone_id)

func on_item_collected(_item_id: String) -> void:
	if QuestManager.current_quest and QuestManager.current_quest.has_method("on_item_collected"):
		QuestManager.current_quest.on_item_collected(_item_id)

func setup_house_exit(house_scene: Node, target_map: String, exit_marker: String):
	var exits = house_scene.find_children("*", "Area2D") # Encontra todas as áreas
	for exit in exits:
		if exit.is_in_group("house_exit"): # Só configura se estiver no grupo certo
			exit.target_map = target_map
			exit.exit_marker = exit_marker
			exit.connect("body_entered", _on_house_exit_entered)

func change_map_and_teleport(map_name: String, entry_marker: String) -> void:
	change_map(map_name, entry_marker)

#ele checa se um inimigo morreu para avisar o pessoal da missão
func on_enemy_destroyed(enemy) -> void:
	QuestManager.current_quest.on_enemy_destroyed(enemy)

func on_quest_finish() -> void:
	print("Missão concluida! preparando a próxima")

func _on_house_exit_entered(body, exit):
	if body == character:
		change_map(exit.target_map)

func shake_camera():
	camera.shake()

func tocar_cutscene(path: String) -> void:
	var cutscene = load(path).instantiate()
	cutscene_layer.add_child(cutscene)

func _process(_delta: float) -> void:
	pass
