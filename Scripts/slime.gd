extends CharacterBody2D
class_name Slime

var _player_ref = null
var _is_dead: bool = false
var health := 3
var knock_dir := Vector2.ZERO
var knock_timer := 0.08
var flashing := false
@export var knockback_force := 300.0
@export var knockback_time := 0.08
@export var unique_id: String = ""
@export var damage_cooldown := 1.0
var damage_cooldown_timer := 0.0

@export_category("Objects")
@export var _texture: Sprite2D = null
@export var _animation: AnimationPlayer = null

@onready var game = get_tree().get_first_node_in_group("game")

func take_hit(dmg: int, attacker_pos: Vector2):
	if _is_dead: return
	
	health -= dmg
	flash_white()
	apply_knockback(attacker_pos)
	
	if health <= 0:
		die()
		
func flash_white():
	flashing = true
	_texture.modulate = Color(1.8, 1.8, 1.8, 1)
	await get_tree().create_timer(0.08).timeout
	_texture.modulate = Color(1, 1, 1, 1)
	flashing = false
	
func apply_knockback(attacker_pos: Vector2):
	knock_dir = (global_position - attacker_pos).normalized()
	knock_timer = knockback_time
	
func die():
	if _is_dead: return
	_is_dead = true
	if not unique_id.is_empty():
		WorldState.mark_entity_defeated(unique_id)
	game.on_enemy_destroyed(self)
	velocity = Vector2.ZERO
	_animation.play("death")

func _on_detection_area_body_entered(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = _body


func _on_detection_area_body_exited(_body) -> void:
	if _body.is_in_group("character"):
		_player_ref = null
		_animation.play("idle")
		
		
		
func _physics_process(_delta: float) -> void:
	if _is_dead:
		move_and_slide()
		return
		
	if knock_timer > 0.0:
		knock_timer -= _delta
		velocity = knock_dir * knockback_force
		move_and_slide()
		_animate()
		return
		
	_animate()
	
	if damage_cooldown_timer > 0.0:
		damage_cooldown_timer -= _delta
	
	if _player_ref != null:
		if _player_ref.is_dead:
			velocity = Vector2.ZERO
			move_and_slide()
			return
			
		var _direction: Vector2 = global_position.direction_to(_player_ref.global_position)
		var _distance: float = global_position.distance_to(_player_ref.global_position)
		
		if _distance < 20 and damage_cooldown_timer <= 0.0:
			_player_ref.take_damage(1, global_position)
			damage_cooldown_timer = damage_cooldown
		
		velocity = _direction * 30
		move_and_slide()

func _animate() -> void:
	if flashing:
		return
		
	if velocity.x > 0:
		_texture.flip_h = false
		
	if velocity.x < 0:
		_texture.flip_h = true
	
	if velocity != Vector2.ZERO:
		_animation.play("walk")
		return
		
	_animation.play("idle")

func _on_animation_animation_finished(_anim_name: StringName) -> void:
	queue_free()
