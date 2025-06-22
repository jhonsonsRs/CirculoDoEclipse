extends Node2D


func _ready() -> void:
	$espelho_normal.show()
	await get_tree().create_timer(3.0).timeout
	$espelho_normal.hide()
	$espelho_quebrado.show()
	await get_tree().create_timer(2.0).timeout
	$espelho_quebrado.hide()
	$espelho_quebrado_sangue.show()
	await get_tree().create_timer(2.0).timeout
	queue_free()
