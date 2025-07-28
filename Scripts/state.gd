extends Node2D
class_name State 

@onready var debug = owner.find_child("debug")
@onready var player: Character = get_tree().get_first_node_in_group("character")
@onready var animation_player = owner.find_child("AnimationPlayer") 

#quando um estado é carregado na memória, ele começa desligado por padrão
#isso garante que apenas o estado ativo execute o código
func _ready():
	set_physics_process(false)

#função para ligar o estado. É chamado pelo FiniteStateMachine
func enter():
	set_physics_process(true)

#função para desligar o estado
func exit():
	set_physics_process(false)

#é uma função vazia que será preenchida por cada estado filho
#é aqui que cada estado define suas regras para mudar outro estado
func transition():
	pass

#a cada frame, executa a verificação de transição e atualiza o texto de debug
func _physics_process(_delta):
	transition()
	debug.text = name
