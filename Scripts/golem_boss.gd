extends CharacterBody2D

@onready var player: Character = get_tree().get_first_node_in_group("character")
@onready var sprite = $Flipper/Sprite2D
@onready var state_machine = $FiniteStateMachine
@onready var progress_bar = $UI/ProgressBar
@onready var flipper = $Flipper

var knock_dir := Vector2.ZERO
var knock_timer := 0.08
var flashing := false
@export var knockback_force := 300.0
@export var knockback_time := 0.08

var direction: Vector2
var DEF = 0

var health := 100

func _ready():
	set_physics_process(false)

func _process(_delta):
	direction = player.global_position - global_position

	if direction.x > 0:
		flipper.scale.x = 1 
	elif direction.x < 0:
		flipper.scale.x = -1 

func take_hit(dmg: int, _attacker_pos: Vector2):
	if state_machine.current_state.name == "Death":
		return
		
	
	health -= (dmg - DEF)
	progress_bar.value = health
	flash_white()
	apply_knockback(_attacker_pos)
	
	if health <= 0:
		state_machine.change_state("Death")
	elif health <= progress_bar.max_value / 2 and DEF == 0:
		DEF = 5
		state_machine.change_state("ArmorBuff")
		
		
func _on_melee_hitbox_body_entered(body) -> void:
	if body.is_in_group("character"):
		body.take_damage(1, global_position)

func flash_white():
	flashing = true
	sprite.modulate = Color(1.8, 1.8, 1.8, 1)
	await get_tree().create_timer(0.08).timeout
	sprite.modulate = Color(1, 1, 1, 1)
	flashing = false
	
func apply_knockback(attacker_pos: Vector2):
	knock_dir = (global_position - attacker_pos).normalized()
	knock_timer = knockback_time

func _physics_process(delta):
	velocity = direction.normalized() * 20
	move_and_collide(velocity *  delta)
	if knock_timer > 0.0:
		knock_timer -= delta
		velocity = knock_dir * knockback_force
		move_and_slide()
		return
	
func take_damage():
	health -= 10 - DEF
