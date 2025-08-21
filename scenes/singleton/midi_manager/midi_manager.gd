extends Node

signal note_pressed(input_event : InputEventMIDI)

@export_file("*.csv") var _notes_csv
var _notes : Array

var _max_pitch : int = 60
var _min_pitch : int = 60


func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())
	_notes = _read_csv(_notes_csv)

func _input(input_event):
	if input_event is InputEventMIDI:
		match input_event.message:
			MIDI_MESSAGE_NOTE_ON:
				var pitch = input_event.pitch
				if pitch > _max_pitch:
					_max_pitch = pitch
				elif pitch < _min_pitch:
					_min_pitch = pitch
					
				note_pressed.emit(input_event)


func midi_pitch_to_note_name(pitch : int) -> String:
	for note in _notes:
		if note['midi_note_number'] == pitch:
			return note['note_names_en']
	return "??"


func _read_csv(file_path: String) -> Array:
	var file = FileAccess.open(file_path, FileAccess.READ)
	var data = []

	if file:
		var header = []
		var first_line = true
		
		while not file.eof_reached():
			var line = file.get_line().strip_edges()
			if line != "":
				var values = line.split(",")  # Split by comma
				if first_line:
					header = values  # Store header for keys
					first_line = false
				else:
					var row = {}
					for i in range(header.size()):
						var value_to_add = values[i]
						if value_to_add.is_valid_int():
							value_to_add = int(value_to_add)
						elif value_to_add.is_valid_float():
							value_to_add = float(value_to_add)
						row[header[i]] = value_to_add
					data.append(row)

		file.close()
	else:
		print("Failed to open file: ", file_path)

	return data
