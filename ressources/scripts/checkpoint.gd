@tool
@icon("res://ressources/images/checkpoint_icon.svg")
class_name Checkpoint
extends Area2D

@export var bounding_box: Vector2 = Vector2(32, 32):
	set(value):
		bounding_box = value
		if collision != null:
			collision.shape.size = bounding_box

@export var coordinates: Vector2:
	set(value):
		coordinates = value
		if collision != null:
			collision.position = coordinates

var collision: CollisionShape2D = null

func _ready() -> void:
	collision = CollisionShape2D.new()
	collision.shape = RectangleShape2D.new()
	collision.shape.size = Vector2(10, 10)
	collision.position = coordinates
	add_child(collision)
