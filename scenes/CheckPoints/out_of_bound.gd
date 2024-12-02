extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("tp_back_to_checkpoint"):
		body.tp_back_to_checkpoint()
	
