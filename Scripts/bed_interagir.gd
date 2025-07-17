extends Area2D
class_name BedInteractable
# Este é um Script da Area2D da cama (faz interagir)
# class_name da um nome customizado para a classe

# variável que faz referência ao player
var _player_ref: Character = null

var player_in_range: bool = false
# player_in_range: é um boolean onde controla se o player entrou na área
var _can_interact: bool = true

@export_category("Objects")
@export var _interaction_icon: Texture2D = preload("res://Assets/button-E.png")
@export var blink_speed: float = 0.5
# @export: permite que eu arraste nós para o Inspetor. ex: hud, blink_speed

var _icon_instance: Sprite2D
@onready var _sprite: Sprite2D = $"../Texture"
var _tween: Tween

#func _ready(): ela é chamada uma vez quando o nó entra na árvore de scenas
func _ready() -> void:
	# aqui um novo Sprite2D é criado via Código (poderia criar manualmente também)
	_icon_instance = Sprite2D.new()
	# aqui ele recebe a texture pré carregada
	_icon_instance.texture = _interaction_icon
	_icon_instance.position = Vector2(0, -10)
	_icon_instance.visible = false
	# o torna invísivel por padrão
	add_child(_icon_instance)
	# aqui ele adiciona o ÍCONE como filho do nó, ou seja, ele vai se mover junto com a cama


# estas aqui são funções de sinais, está por sua vez checa se algum corpo entrou na área2D
func _on_body_entered(_body) -> void:
	# verifica se o corpo que entrou na área é o player 
	if _body is Character:
		_player_ref = _body
		# se for, o player_in_range é true(ele está na área)
		player_in_range = true
		if _can_interact:
			# o icon fica vísivel
			_icon_instance.visible = true
			# inicia a "animação" de piscar
			_start_blinking()


# é uma função de sinal que checa se o corpo saiu da área2D
func _on_body_exited(_body) -> void:
	# verifica se o corpo que saiu foi o do player
	if _body is Character:
		_player_ref = null
		# se foi, o player não está mais na área, então player_in_range é falso
		player_in_range = false
		# daí o icon fica invísivel novamente
		_icon_instance.visible = false
		# para de piscar
		_stop_blinking()
		
		
# ESTA FUNÇÃO é chamada a CADA frame do jogo, ela é ideal para verificar inputs
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and player_in_range and _can_interact:
		if Dialogic.current_timeline != null:
			return
		_can_interact = false
		_icon_instance.visible = false
		_stop_blinking()
		
		# Inicia a timeline do Dialogic
		Dialogic.start("cama_interacao")
		get_viewport().set_input_as_handled()
		if not Dialogic.timeline_ended.is_connected(_on_dialog_finished_enable_interaction):
			Dialogic.timeline_ended.connect(_on_dialog_finished_enable_interaction)
		
func _start_blinking() -> void:
	# cria um tween, é uma ferramenta pra animar propriedades de um objeto por um longo tempo
	_tween = create_tween()
	# faz a animação se repetir infinitamente
	_tween.set_loops()
	# aqui vai animar a propriedade, neste caso está modificando o "modulate:a", ou seja, o alpha da textura Cama
	_tween.tween_property(_sprite, "modulate:a", 0.7, blink_speed/2).from_current()
	_tween.tween_property(_sprite, "modulate:a", 1.0, blink_speed/2)
	
	
func _stop_blinking() -> void:
	if _tween:
		# aqui para e remove o tween da memória, interrompendo a animação
		_tween.kill()
	# garante que a cama ficou totalmente normal
	_sprite.modulate.a =  1.0

func _on_dialog_finished_enable_interaction() -> void:
	_can_interact = true
	if player_in_range:
		_icon_instance.visible = true
		_start_blinking()
# EM RESUMO: a função _ready() cria um ícone de interação visível
# os sinais verificam se algum corpo entrou na Area2D
# a função _process() verifica se o player apertou o input "interact" mapeada
