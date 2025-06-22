extends CharacterBody2D
class_name Character

var _state_machine
var is_dead = false
var _is_attacking: bool = false
var tem_lanterna: bool = false

@export_category("Variables")
@export var speed: float = 64.0;
@export var _acceleration: float = 0.4
@export var _friction: float = 0.8

@export_category("Objects")
@export var _animation_tree: AnimationTree = null
@export var _attack_timer: Timer = null

@onready var point_light: PointLight2D = $PointLight2D
func _ready() -> void:
	_animation_tree.active = true
	_state_machine = _animation_tree["parameters/playback"]
	
func _physics_process(_delta: float) -> void:
	if is_dead:
		return 
	_move()
	_attack()
	_animate()
	move_and_slide()
	_activate_lantern()
	
func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		_animation_tree["parameters/attack/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * speed, _acceleration)
		return
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * speed, _friction)

func _attack() -> void:
	if Input.is_action_just_pressed("attack") and _is_attacking == false:
		set_physics_process(false)
		_attack_timer.start()
		_is_attacking = true

func _activate_lantern() -> void:
	if Input.is_action_just_pressed("lantern") and tem_lanterna:
		point_light.visible = !point_light.visible

func _animate() -> void:
	if _is_attacking:
		_state_machine.travel("attack")
		return

	if velocity.length() > 2:
		_state_machine.travel("walk")
		return
	
	_state_machine.travel("idle")


func _on_attack_timer_timeout() -> void:
	set_physics_process(true)
	_is_attacking = false


func _on_attack_area_body_entered(_body) -> void:
	if _body.is_in_group("enemy"):
		_body.update_health()

func die() -> void:
	is_dead = true
	_state_machine.travel("death")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

func disable_movement() -> void:
	set_physics_process(false)
	_state_machine.travel("idle")
	
func enable_movement() -> void:
	set_physics_process(true)

func _on_lanterna_coletada() -> void:
	tem_lanterna = true
	point_light.visible = true
	
