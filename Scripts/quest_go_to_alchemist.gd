extends Quest
class_name Quest_GoToAlchemist

var quest_id_string = "go_to_alchemist"

func _init() -> void:
	self.mission_id = QuestManager.QuestID.GoToAlchemist
	print("Nova missão: Vá para a casa do Alquimista.")
	
func on_map_changed(previous_map_name: String, new_map_name: String) -> void:
	if new_map_name == "casa_alquimista":
		print("Você chegou à casa do Alquimista! Missão Concluída!")
		WorldState.mark_quest_complete(quest_id_string)
		QuestManager.on_quest_finish()
