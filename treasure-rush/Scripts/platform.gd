extends Sprite2D

@export var lever_path: NodePath
@export var pressure_plate_path: NodePath

@export var rotation_angle := 0
@export var rotation_time := 1

var aberta := false
var girando := false

@onready var lever: Node = get_node_or_null(lever_path)
@onready var pressure_plate: Node = get_node_or_null(pressure_plate_path)

func _ready() -> void:
	if is_instance_valid(lever) and lever.has_signal("lever_on"):
		lever.connect("lever_on", Callable(self, "_on_activated"))
	elif is_instance_valid(pressure_plate) and pressure_plate.has_signal("plate_on"):
		pressure_plate.connect("plate_on", Callable(self, "_on_activated"))

func _on_activated() -> void:
	alternar()

func alternar() -> void:
	if girando:
		return

	girando = true
	aberta = !aberta

	var alvo := deg_to_rad(rotation_angle) if aberta else 0.0

	var tween := create_tween()
	tween.tween_property(self, "rotation", alvo, rotation_time)

	await tween.finished
	girando = false
