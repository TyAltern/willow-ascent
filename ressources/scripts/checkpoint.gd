@tool
@icon("res://ressources/images/checkpoint_icon.svg")
class_name Checkpoint
extends Area2D

@export var bounding_box: Vector2 = Vector2(32, 32):
	get:
		return bounding_box
	set(value):
		bounding_box = value
		if collision != null:
			collision.shape.size = bounding_box
@export var coordinates: Vector2:
	get:
		return coordinates
	set(value):
		coordinates = value
		if collision != null:
			collision.position = coordinates
@export var respawn_coordinates: Vector2

var collision: CollisionShape2D = null

func _ready() -> void:
	collision = CollisionShape2D.new()
	# Add collision shape (rect)
	collision.shape = RectangleShape2D.new()
	collision.shape.size = bounding_box
	collision.position = coordinates
	# Connect enter and exit signals
	body_entered.connect(_on_checkpoint_body_entered)
	body_exited.connect(_on_checkpoint_body_exited)
	add_child(collision)

func _on_checkpoint_body_entered(body: Node2D):
	if body.has_meta("checkpoint_id"):
		body.set_meta("checkpoint_id", self.name)
		body.set_meta("checkpoint_coordinates", respawn_coordinates)

func _on_checkpoint_body_exited(body: Node2D):
	if body.has_meta("checkpoint_id"):
		if body.get_meta("checkpoint_id") == self.name:
			body.kill()
