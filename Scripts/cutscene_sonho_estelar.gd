extends Node2D


func _ready() -> void:
	$AudioStreamPlayer.play()
	await get_tree().create_timer(3.0).timeout
	$GlifoSprite.show()
	await get_tree().create_timer(2.0).timeout
	$GlifoSprite.hide()
	$AudioStreamPlayer2.play()
	await get_tree().create_timer(4.0).timeout
	queue_free()
	var main = get_tree().root.get_node("main")
	main.trocar_cena_do_jogo("res://Lugares/Scenes/level1.tscn")

func _process(_delta: float) -> void:
	pass
