extends Quest
class_name QuestLeaveCabin

var quest_id_string = "leave_cabin"

func _init() -> void:
	self.mission_id = QuestManager.QuestID.LeaveCabin
	print("Nova missão iniciada! Sair da cabana")
	
func on_map_changed(previous_map_name: String, new_map_name: String) -> void:
	print("Evento de mapa recebido! Saí de '", previous_map_name, "' e entrei em '", new_map_name, "'")

	if previous_map_name == "cabana":
		print("VOCÊ SAIU DA CABANA! MISSÃO CONCLUÍDA!")
		WorldState.mark_quest_complete(quest_id_string)
		QuestManager.on_quest_finish()
