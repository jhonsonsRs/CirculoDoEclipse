extends Node2D
class_name Corrupted_Crystal

var player_ref: Character = null
var player_in_range: bool = false
var unique_id: String = ""

@export var interaction_icon: Texture2D = preload("res://Assets/button-E.png")
var icon_instance: Sprite2D
@onready var item_id: String = "corrupted_crystal"
@onready var game = get_tree().get_first_node_in_group("game")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon_instance = Sprite2D.new()
	icon_instance.texture = interaction_icon
	icon_instance.position = Vector2(0, -10)
	icon_instance.visible = false
	add_child(icon_instance)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range == true:
		WorldState.mark_collected(unique_id)
		game.on_item_collected(unique_id)
		print("Cristal '", unique_id, "' coletado!")
		queue_free()



func _on_area_2d_body_entered(body) -> void:
	if body is Character:
		player_ref = body
		player_in_range = true
		icon_instance.visible = true


func _on_area_2d_body_exited(body) -> void:
	if body is Character:
		player_ref = null
		player_in_range = false
		icon_instance.visible = false
