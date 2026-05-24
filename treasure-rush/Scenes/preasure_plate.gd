extends AnimatedSprite2D

signal plate_on

@onready var sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

var activated := false

func _ready() -> void:
	stop()
	frame = 0

func _on_body_entered(body: Node2D) -> void:
	if activated:
		return
	if !body.is_in_group("rock"):
		return

	activated = true
	stop()
	frame = 1

	if sound:
		sound.play()

	plate_on.emit()
