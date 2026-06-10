extends AnimatedSprite2D

@export_file("*.tscn") var next_scene: String

@export var lever: Node
@export var pressure_plate: Node

@onready var sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var unlocked := false

func _ready() -> void:
	stop()
	frame = 0

	if lever != null and lever.has_signal("lever_on"):
		lever.lever_on.connect(unlock)

	elif pressure_plate != null and pressure_plate.has_signal("plate_on"):
		pressure_plate.plate_on.connect(unlock)

func unlock() -> void:
	if unlocked:
		return

	unlocked = true

	stop()
	frame = 1

	if sound:
		sound.play()

func _on_body_entered(body: Node2D) -> void:
	if !unlocked:
		return

	if !body.is_in_group("player"):
		return

	if next_scene.is_empty():
		push_warning("Next scene não definida.")
		return

	get_tree().change_scene_to_file.call_deferred(next_scene)
