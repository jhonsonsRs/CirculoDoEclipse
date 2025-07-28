extends State

#pega a referência à área de detecção e barra de vida
@onready var collision = $"../../PlayerDetection/CollisionShape2D"
@onready var progress_bar = owner.find_child("ProgressBar")
	
#uma variável booleana para saber se o jogador entrou na área
#a mágica está no "set(value)": toda vez que o valor de "player_entered" muda,
#o código dentro do set é executado automaticamente
var player_entered:bool = false:
	set(value):
		player_entered = value
		#set_deferred é uma forma segura de ativar/desativar coisas
		#relacionadas a física, evitando bugs
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible", value)

#a regra de transi;'ao do idle
func transition():
	#se o player entrou na área...
	if player_entered: 
		#... mande o cérebro (get_parent()) mudar para o estado "Follow"
		get_parent().change_state("Follow")

#é um sinal conectado a área "PlayerDetection"
#ela é chamada quando o player entra na área
func _on_player_detection_body_entered(_body):
	#ao definir a variável como true, o código do set é disparado
	player_entered = true
