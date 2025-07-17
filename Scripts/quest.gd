extends Node
class_name Quest

#esta é uma classe base
#é um molde em branco. Diz que toda missão DEVE ter um id e deve ter uma função on_enemy_destroyed

var mission_id
var level_of_map = { }

#uma função para a missão se configurar quando um novo mapa é carregado
func on_level_loaded (_level: Level) -> void:
	pass

#uma função para a missão reagir á morte de um inimigo
func on_enemy_destroyed(_enemy) -> void:
	pass
