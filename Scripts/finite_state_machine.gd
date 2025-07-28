extends Node2D
 
var current_state: State
var previous_state: State
 
func _ready():
	#ao iniciar, pega o primeiro filho da lista (Idle)
	#e o define como estado inicial. "as State" garante que é um estado válido
	current_state = get_child(0) as State
	previous_state = current_state
	#chama a função enter() do estado Idle para ativar
	current_state.enter()
 
func change_state(state):
	#procura por um nó filho com o nome que foi passado (ex: "Follow")
	current_state = find_child(state) as State
	#chama a função enter() do novo estado para ativá-lo
	current_state.enter()
 
	#chama a função exit() do antigo estado para desativá-lo
	previous_state.exit()
	#atualiza a memória para que na próxima troca, ele saiba quem é o estado antigo
	previous_state = current_state
 
