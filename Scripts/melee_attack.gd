extends State

@onready var melee_hitbox_shape = owner.find_child("Flipper").find_child("MeleeHitbox").find_child("CollisionShape2D")

#é uma trava
var can_transition: bool = false

func enter():
	#assim que entra no estado, a trava é acionada (false)
	#o chefe NÃO PODE sair desse estado ainda
	can_transition = false
	super.enter() #chama o enter do State
	animation_player.play("melee_attack") #ativa a animação
	await animation_player.animation_finished
	can_transition = true
	
	
func exit():
	super.exit()
	melee_hitbox_shape.set_deferred("disabled", true)

#regra de transição: se o jogador se afastar enquanto o golem ataca...
func transition():
	if can_transition:
		get_parent().change_state("Follow")
