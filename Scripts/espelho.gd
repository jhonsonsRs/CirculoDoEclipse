extends Node2D
class_name espelho

var player_ref: Character = null
var player_in_range: bool = false
var can_interact: bool = true

@export_category("Objects")
@export var interaction_icon: Texture2D = preload("res://Assets/button-E.png")

@onready var sprite_espelho: Sprite2D = $espelho_normal
@onready var sprite_espelho_quebrado: Sprite2D = $espelho_quebrado

var icon_instance: Sprite2D

func _ready() -> void:
	icon_instance = Sprite2D.new()
	icon_instance.texture = interaction_icon
	icon_instance.position = Vector2(0, -10)
	icon_instance.visible = false
	add_child(icon_instance)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range == true and can_interact:
		var game = get_node("/root/Game")
		game.tocar_cutscene("res://Scenes/cutscene_espelho.tscn")
		can_interact = false
		icon_instance.visible = false
		sprite_espelho.visible = false
		sprite_espelho_quebrado.visible = true
		


func _on_area_2d_body_entered(_body) -> void:
	if _body is Character:
		player_ref = _body
		player_in_range = true
		if can_interact:
			icon_instance.visible = true


func _on_area_2d_body_exited(_body) -> void:
	if _body is Character:
		player_ref = null
		player_in_range = false
		icon_instance.visible = false
