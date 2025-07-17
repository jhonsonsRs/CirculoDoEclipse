extends Node2D

@export var target_map_name: String = "floresta"  # Nome do mapa destino (como está no seu Game.gd)
@export var exit_marker_name: String = "CabanaExit"  # Nome do Marker2D no mapa destino

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	pass

func _on_area_2d_body_entered(_body) -> void:
	if _body is Character:
		var game := get_node("/root/Game")  # Acessa o gerenciador principal
		
		# Muda para o mapa de destino
		game.call_deferred("change_map_and_teleport", target_map_name, exit_marker_name)
		# Posiciona o jogador no marcador correto
		var exit_point = game.current_map_node.get_node_or_null(exit_marker_name)
		if exit_point:
			_body.global_position = exit_point.global_position
