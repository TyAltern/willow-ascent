extends Area2D

@onready var checkpoint_relative_coordinate = global_position


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("save_checkpoint_coordinate"):
		body.save_checkpoint_coordinate(checkpoint_relative_coordinate)
