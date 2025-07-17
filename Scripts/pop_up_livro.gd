extends Panel

func _input(event) -> void:
	if visible and event.is_action_pressed("leave"):
		visible = false
		var area_livro = get_node("../../Area2D")
		area_livro.can_interact = true
		if area_livro.player_in_range == true:
			area_livro.icon_instance.visible = true
			area_livro.start_blinking()
