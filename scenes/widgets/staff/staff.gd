extends Control

@export var note_scene : PackedScene
@export var chord_spawn_center : Control

func _ready() -> void:
	# _spawn_note(0)
	pass

func _spawn_note(index_offset : int) -> void:
	var new_note = note_scene.instantiate()
	chord_spawn_center.add_child(new_note)
