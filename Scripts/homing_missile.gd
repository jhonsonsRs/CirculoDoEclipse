extends State

@export var bullet_node: PackedScene
#um interruptor para garantir que a transição só ocorra depois do tiro
var can_transition: bool = false

func enter():
	super.enter()
	animation_player.play("ranged_attack")
	#AWAIT: pausa a execução dessa função até a animação terminar
	await animation_player.animation_finished
	shoot()
	can_transition = true #libera a transição

func shoot():
	#cria uma nova instância da cena do projétil
	var bullet = bullet_node.instantiate()
	bullet.position = owner.position #define a posição inicial do projétil
	#adiciona o projétil na cena principal do jogo
	get_tree().current_scene.add_child(bullet)

#regra de transição: se o tiro ja foi dado...
func transition():
	if can_transition:
		can_transition = false #reseta o interruptor
		#...muda para o estado de dash
		get_parent().change_state("Dash")
