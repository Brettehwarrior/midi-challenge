extends HBoxContainer

@export var note_prompt_label : Label
@export var _musiqwik_staff : MusiQwikStaff

var _current_note


func _ready() -> void:
	_pick_random_note()
	MidiManager.note_pressed.connect(_on_note_pressed)


func _pick_random_note() -> void:
	var note = MidiManager.get_random_note()
	note_prompt_label.text = note['note_names_en']
	_current_note = note
	_musiqwik_staff.display_note(note)


func _on_note_pressed(input_event : InputEventMIDI) -> void:
	if input_event.pitch == _current_note['midi_note_number']:
		_pick_random_note()
