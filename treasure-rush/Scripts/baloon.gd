extends Node2D

@export var lever_path: NodePath
@export var pressure_plate_path: NodePath

@export var scale_multiplier := 3.0
@export var grow_time := 1.0

var inflado := false
var animando := false
var escala_original := Vector2.ONE

@onready var lever = get_node_or_null(lever_path)
@onready var pressure_plate = get_node_or_null(pressure_plate_path)

func _ready() -> void:
	escala_original = scale

	if lever and lever.has_signal("lever_on"):
		lever.lever_on.connect(_on_activated)

	elif pressure_plate and pressure_plate.has_signal("plate_on"):
		pressure_plate.plate_on.connect(_on_activated)

func _on_activated() -> void:
	inflar()

func inflar() -> void:
	if inflado or animando:
		return

	animando = true

	var tween = create_tween()

	# Pequena antecipação
	tween.tween_property(
		self,
		"scale",
		escala_original * 1.15,
		grow_time * 0.2
	)

	# Crescimento principal
	tween.tween_property(
		self,
		"scale",
		escala_original * scale_multiplier,
		grow_time * 0.8
	)

	await tween.finished

	inflado = true
	animando = false
