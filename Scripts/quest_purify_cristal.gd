extends Quest
class_name Quest_PurifyCrystals

var quest_id_string = "purify_crystals"

var crystals_to_purify: int = 3
var crystals_purified: int = 0

func _init() -> void:
	self.mission_id = QuestManager.QuestID.PurifyCrystals
	print("Nova missão: Purifique os 3 Cristais na Floresta Distorcida.")
	
func on_item_collected(_item_id: String) -> void:
	if _item_id.begins_with("corrupted_crystal_"):
		crystals_purified += 1
		print("Cristal purificado! Progresso: %d de %d" % [crystals_purified, crystals_to_purify])
		if crystals_purified >= crystals_to_purify:
			print("Todos os cristais foram purificados! Missão Concluída!")
			WorldState.mark_quest_complete(quest_id_string)
			QuestManager.on_quest_finish()
