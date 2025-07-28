extends Quest
class_name Quest_TalkToAlchemist

var quest_id_string = "talk_to_alchemist"

func _init() -> void:
	self.mission_id = QuestManager.QuestID.TalkToAlchemist
	print("Nova missão: Entre e fale com o Alquimista.")
	
func on_dialogue_finished(npc_id: String) -> void:
	if npc_id == "alquimista":
		print("Você falou com o Alquimista! Missão Concluída!")
		WorldState.mark_quest_complete(quest_id_string)
		QuestManager.on_quest_finish()
	
