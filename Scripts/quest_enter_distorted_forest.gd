extends Quest
class_name Quest_EnterDistortedForest

var quest_id_string = "enter_distorted_forest"

func _init() -> void:
	self.mission_id = QuestManager.QuestID.EnterDistortedForest
	print("Nova missão: Vá para a Floresta Distorcida.")
	
func on_zone_entered(zone_id: String) -> void:
	if zone_id == "distorted_forest_entrance":
		print("Você entrou na Floresta Distorcida! Missão Concluída!")
		WorldState.mark_quest_complete(quest_id_string)
		QuestManager.on_quest_finish()
