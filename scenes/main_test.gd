extends Control

@export var _note_history_container : Container
@export var _last_played_note_label : Label


func _ready() -> void:
	MidiManager.note_pressed.connect(_on_note_pressed)


func _on_note_pressed(input_event : InputEventMIDI) -> void:
	_print_note(input_event)


func _print_note(midi_event : InputEventMIDI):
	if midi_event.message != MIDI_MESSAGE_NOTE_ON:
		return

	var note_name = MidiManager.midi_pitch_to_note_name(midi_event.pitch)
	_last_played_note_label.text = note_name
	_append_to_note_history(note_name)


func _append_to_note_history(note_name : String):
	var label = Label.new()
	label.text = note_name
	_note_history_container.add_child(label)
	_note_history_container.move_child(label, 0)

