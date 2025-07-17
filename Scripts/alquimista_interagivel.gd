extends Area2D
class_name npc

var player_ref: Character = null

var player_in_range: bool = false
var can_interact: bool = true

@export_category("Objects")
@export var hud: CanvasLayer = null
@export var interaction_icon: Texture2D = preload("res://Assets/button-E.png")

var icon_instance: Sprite2D
# @onready var _sprite: Sprite2D = $"../Texture"

func _ready() -> void:
	icon_instance = Sprite2D.new()
	icon_instance.texture = interaction_icon
	icon_instance.position = Vector2(0, -10)
	icon_instance.visible = false
	add_child(icon_instance)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range and can_interact:
		if Dialogic.current_timeline != null:
			return
		can_interact = false
		icon_instance.visible = false
		
		# Inicia a timeline do Dialogic
		Dialogic.start("alquimista")
		get_viewport().set_input_as_handled()
		if not Dialogic.timeline_ended.is_connected(_on_dialog_finished_enable_interaction):
			Dialogic.timeline_ended.connect(_on_dialog_finished_enable_interaction)


func _on_body_entered(_body) -> void:
	if _body is Character:
		player_ref = _body
		player_in_range = true
		if can_interact:
			icon_instance.visible = true

func _on_body_exited(_body) -> void:
	if _body is Character:
		player_ref = null
		player_in_range = false
		icon_instance.visible = false
		
func _on_dialog_finished_enable_interaction() -> void:
	can_interact = true
	if player_in_range:
		icon_instance.visible = true
