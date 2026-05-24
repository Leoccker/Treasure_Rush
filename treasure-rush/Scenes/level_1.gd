extends Node2D

@onready var door = $Door
@onready var plate = $"Preasure Plate"

func _ready() -> void:
	plate.plate_on.connect(door.unlock)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
