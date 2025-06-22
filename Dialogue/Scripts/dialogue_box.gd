extends CanvasLayer

@onready var dialogue_panel = $BackgroundPanel
@onready var dialogue_label = $BackgroundPanel/DialogueText

var current_dialogue_lines: Array[String] = []
var current_line_index: int = 0

signal dialogue_finished

func _ready() -> void:
	hide_dialogue_box()
	
func show_dialogue(lines: Array[String]) -> void:
	current_dialogue_lines = lines
	current_line_index = 0
	dialogue_panel.show()
	update_dialogue_text()
	get_tree().paused = true
	
func update_dialogue_text() -> void:
	if current_line_index < current_dialogue_lines.size():
		dialogue_label.text = current_dialogue_lines[current_line_index]
	else:
		hide_dialogue_box()
		emit_signal("dialogue_finished")
		get_tree().paused = false
		
func _input(_event):
	if _event.is_action_just_pressed("interact") and dialogue_panel.visible:
		current_line_index += 1
		update_dialogue_text()
		
func hide_dialogue_box() -> void:
	dialogue_panel.hide()
	current_dialogue_lines.clear()
	current_line_index = 0
