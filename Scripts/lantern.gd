extends Node2D
class_name Lantern_interactable

signal lanterna_coletada

var player_ref: Character = null
var player_in_range: bool = false


@export_category("Objects")
@export var interaction_icon: Texture2D = preload("res://Assets/button-E.png")
@export var blink_speed: float = 0.5

var icon_instance: Sprite2D
var tween: Tween
@onready var _sprite: Sprite2D = $Texture
@onready var item_id: String = "lantern_cabana"

func _ready() -> void:
	icon_instance = Sprite2D.new()
	icon_instance.texture = interaction_icon
	icon_instance.position = Vector2(0, -10)
	icon_instance.visible = false
	add_child(icon_instance)

func _process(_delta) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range == true:
		WorldState.mark_collected(item_id)
		emit_signal("lanterna_coletada")
		queue_free()

func start_blinking() -> void:
	tween = create_tween()
	tween.set_loops()
	tween.tween_property(_sprite, "modulate:a", 0.7, blink_speed / 2).from_current()
	tween.tween_property(_sprite, "modulate:a", 1.0, blink_speed / 2)
	
func stop_blinking() -> void:
	if tween:
		tween.kill()
	_sprite.modulate.a = 1.0


func _on_area_2d_body_entered(_body) -> void:
	if _body is Character:
		player_ref = _body
		player_in_range = true
		icon_instance.visible = true
		start_blinking()

func _on_area_2d_body_exited(_body) -> void:
	if _body is Character:
		player_ref = null
		player_in_range = false
		icon_instance.visible = false
		stop_blinking()
