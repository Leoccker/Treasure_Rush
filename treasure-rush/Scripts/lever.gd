extends AnimatedSprite2D

signal lever_on

@onready var sound = $AudioStreamPlayer2D

var activated := false


func _ready() -> void:
	frame = 0


func _body_entered_on_lever(body: Node2D) -> void:
	if activated:
		return

	if !body.is_in_group("player"):
		return

	activated = true
	frame = 1

	if sound:
		sound.play()

	emit_signal("lever_on")
