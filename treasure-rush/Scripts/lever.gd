extends AnimatedSprite2D

signal lever_on
@onready var sound = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _body_entered_on_lever(body: Node2D) -> void:
	if frame == 0:
		if body.name == "Player":
			frame = 1
			sound.play()
			emit_signal("lever_on")
