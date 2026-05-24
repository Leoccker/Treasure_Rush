extends RigidBody2D

func _ready() -> void:
	GravityManager.gravity_changed.connect(_on_gravity_changed)
	_update_gravity()

func _update_gravity() -> void:
	gravity_scale = -1.0 if GravityManager.inverted else 1.0

func _on_gravity_changed(_inverted: bool) -> void:
	_update_gravity()
