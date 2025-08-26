class_name MusiQwikStaff
extends Label

func _ready() -> void:
	display_note()


func display_note(note : Dictionary = {}) -> void:
	var note_text = note.get("musiqwik_whole_note_treble", "==")
	while len(note_text) < 2:
		note_text = "=" + note_text
	text = "'&=%s=!" % note_text
