extends State

func enter():
	super.enter() #chama o enter do State.gd
	owner.set_physics_process(true) #liga o processamento de física do golem
	animation_player.play("idle") #toca a animação dele parado
	
func exit():
	super.exit() #desliga o _physics_process desse estado
	owner.set_physics_process(false) #desliga a física do golem

#a regra de transição mais complexa
func transition():
	#owner.direction é uma variável do golem que calcula a distancia do golem para o jogador
	#e a distancia daqui, pega a distancia que o golem esta do jogador
	var distance = owner.direction.length()
	
	#se a distancia for menor que 30...
	if distance < 30:
		#...mude para o ataque corpo a corpo
		get_parent().change_state("MeleeAttack")
	#se for maior que 80...
	elif distance > 80:
		#sorteia um numero (0 ou 1)
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("HomingMissile")
			1:
				get_parent().change_state("LaserBeam")
		
