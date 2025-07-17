extends Quest
class_name QuestKillSlime
#é o preenchimento do molde. é a missão real
#"meu objetivo é matar 3 slimes. Vou manter uma contagem (slimes_killed) e quando chegar a 3, avisarei que terminei

var slimes_to_kill: int = 3
var slimes_killed: int = 0
var quest_id_string = "kill_slimes"

func _init() -> void:
	self.mission_id = QuestManager.QuestID.KillSlimes
	print("Nova missão iniciada! matar %d Slimes" % slimes_to_kill)
	
func on_enemy_destroyed(enemy) -> void:
	if WorldState.is_quest_complete(quest_id_string):
		return
	if enemy is Slime:
		slimes_killed += 1
		if slimes_killed >= slimes_to_kill:
			print("Objetivo concluido")
			WorldState.mark_quest_complete(quest_id_string)
			QuestManager.on_quest_finish()
