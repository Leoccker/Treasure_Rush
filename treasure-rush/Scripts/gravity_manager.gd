extends Node

var inverted: bool = false

signal gravity_changed(inverted: bool)

func toggle() -> void:
	inverted = not inverted
	gravity_changed.emit(inverted)
