extends Node2D
class_name Level

const _DIALOG_SCREEN: PackedScene = preload("res://Dialogue/Scene/dialogue_screen.tscn")
var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://Character/Assets/11.png",
		"dialog": "Sou uma cama, legal né",
		"title": "Cama"
	},
	
	1: {
		"faceset": "res://Character/Assets/11.png",
		"dialog": "Agora eu tambem sou uma cama",
		"title": "Cama"
	}
}

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
		_new_dialog.data = _dialog_data
		_hud.add_child(_new_dialog)
