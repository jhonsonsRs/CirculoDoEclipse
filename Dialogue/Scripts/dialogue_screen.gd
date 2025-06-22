extends Control
# define que o script controla um nó de Control, que são feitos para criar interface, painéis, etc
class_name DialogScreen

signal dialog_started
signal dialog_finished

var _step: float = 0.05
# controla a velocidade que o texto aparece

var _id: int = 0
# funciona como um marcador de páginas, ele controla qual fala do dicionário será exibida
var data: Dictionary = {}
# dicionário vazio por padrão, ele será preenchido por outro script, é aqui onde textos e imagens ficam armazenadas

@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null
@export var choice_box: VBoxContainer

@onready var button_scene := preload("res://Dialogue/Scene/choice_button.tscn")

# é chamada uma vez assim que a DialogScreen é adicionada a cena
func _ready() -> void:
	_initialize_dialog()

# é chamada a cada frame e gerencia a interação do jogador COM A CAIXA DE DIÁLOGO
func _process(_delta: float) -> void:
	# se o jogador estiver segurando a tecla de ação "enter ou espaço" e o texto
	# ainda não terminou de aparecer, o _step fica mais RÁPIDO
	if Input.is_action_pressed("ui_accept") and _dialog.visible_ratio < 1:
		_step = 0.01
		return
		
	# se não, fica normal
	_step = 0.05
	
	# verifica se o jogador deu um toque no botão (e ja acabou de aparecer, pois saiu da condição aciima)
	if Input.is_action_just_pressed("ui_accept"):
		# avança para a próxima fala
		_id += 1
		# se o id for igual o numero máximo de falas, não tem mais o que fazer
		if _id == data.size():
			emit_signal("dialog_finished")
			# aqui DESTRÓI a cena
			queue_free()
			return
			
		# se não acabou, a função é chamada novamente para mostrar a próxima fala
		_initialize_dialog()

# Este é um efeito máquina de escrever
func _initialize_dialog() -> void:
	emit_signal("dialog_started")
	
	if "choice" in data[_id] and data[_id]["choice"] == true:
		$Background.visible = false
		choice_box.visible = true
		for child in choice_box.get_children():
			child.queue_free()

		var options = data[_id]["options"]
		for option in options:
			var btn = button_scene.instantiate()
			btn.text = option["text"]
			btn.pressed.connect(func():
				_id = option["next_id"]
				_reset_dialog()
			)
			choice_box.add_child(btn)

		return

	# Se não for escolha
	$Background.visible = true
	choice_box.visible = false

	
	# Nestas três linhas, elas pegam as informações do Dicionário data utilizando o id
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	_faceset.texture = load(data[_id]["faceset"])
	
	# primeiro o texto é zerado, dai nenhum caracter fica visivel
	_dialog.visible_characters = 0
	# inicia um loop que continuará rodando enquanto o texto não estiver 100% visivel
	while _dialog.visible_ratio < 1:
		#create_timer(step) cria um timer com a duração da varíavel step
		#await ... timeout pausa a execução dessa função sem travar o jogo inteiro
		await get_tree().create_timer(_step).timeout
		#ai as letras vão passando
		_dialog.visible_characters += 1


func _reset_dialog():
	for child in choice_box.get_children():
		child.queue_free()
	choice_box.visible = false
	$Background.visible = true
	_initialize_dialog()
