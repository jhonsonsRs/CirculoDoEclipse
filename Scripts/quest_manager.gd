extends Node
class_name Quest_Manager

@onready var game = get_tree().get_first_node_in_group("game")

#lista ordenadas das quests. O valor númerico (0, 1, 2...)
enum QuestID {
	LeaveCabin,
	GoToAlchemist,
	TalkToAlchemist,
	EnterDistortedForest,
	PurifyCrystals
}

#armazena a instância da missão que o jogador está fazendo
var current_quest : Quest

#dicionario que mapeia um QuestID para o script da missão
var quest_types = {
	QuestID.LeaveCabin : QuestLeaveCabin,
	QuestID.GoToAlchemist: Quest_GoToAlchemist,
	QuestID.TalkToAlchemist: Quest_TalkToAlchemist,
	QuestID.EnterDistortedForest: Quest_EnterDistortedForest,
	QuestID.PurifyCrystals: Quest_PurifyCrystals
	# QuestID.Foo : QuestFoo
}

#aqui instancia a primeira quest quando o jogo inicia
func _init () -> void:
	var start_quest_id = QuestID.LeaveCabin
	current_quest = quest_types[start_quest_id].new()
	
#é chamado pela própria missão quando ela termina. Ele descobre qual é a próxima missão, cria uma nova instância dela e avisa o game_manager
func on_quest_finish() -> void:
	if current_quest == null:
		print("Nenhuma missão ativa para finalizar.")
		return
	
	var next_quest_id : QuestID = self.current_quest.mission_id + 1
	
	if quest_types.has(next_quest_id):
		self.current_quest = self.quest_types[next_quest_id].new()
		#avisa o game_manager que a quest acabou
		game.on_quest_finish()
	else:
		# Se não, significa que todas as missões acabaram!
		print("Parabéns, você completou todas as missões!")
		self.current_quest = null
