extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_parent().find_child("Character")

var acceleration: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	#1. calcula a direção até o jogador
	acceleration = (player.position - position).normalized() * 250
	
	#2. adiciona aceleração à velocidade
	velocity += acceleration * delta
	
	#3. gira a bala para apontar na direção da velocidade
	rotation = velocity.angle()
	
	#4. limita a velocidade máxima
	velocity = velocity.limit_length(150)
	
	#5. Move a bala
	position += velocity * delta

#ao colidir com qualquer corpo...
func _on_body_entered(_body) -> void:
	#... se destrói.
	queue_free()
