extends AnimatedSprite2D

signal preasure_plate_on
@onready var sound = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _body_entered_on_preasure_plate(body: Node2D) -> void:
	if frame == 0:
		if body.name == "Rock":
			frame = 1
			sound.play()
			emit_signal("preasure_plate_on")
