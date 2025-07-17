extends Node
#ele não decide NADA. Ele só lembra fatos. exemplo: vê se a lanterna foi coletada

var items := {
	"book_cabana": true,
	"lantern_cabana": true
}

var entity_states := {
	"floresta_slime_01": true,
	"floresta_slime_02": true,
	"floresta_slime_03": true
}

var quest_completion := {
	"kill_slimes": false
}

func is_active(id: String) -> bool:
	return items.get(id, true)

func mark_collected(id: String) -> void:
	items[id] = false

func is_entity_alive(id: String) -> bool:
	return entity_states.get(id, true)
	
func mark_entity_defeated(id: String) -> void:
	entity_states[id] = false
	
func is_quest_complete(id: String) -> bool:
	return quest_completion.get(id, false)
	
func mark_quest_complete(id: String) -> void:
	quest_completion[id] = false
	
