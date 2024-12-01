extends Control

func resize():
	$Level.position = get_viewport_rect().size/2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resize()
	get_tree().get_root().size_changed.connect(resize)
