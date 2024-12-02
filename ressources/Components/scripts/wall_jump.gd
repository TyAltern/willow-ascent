extends Node2D

@onready var player: CharacterBody2D = $"../.."


func _process(_delta: float) -> void:
	if player.faced_wall != 0:
		if Input.is_action_just_pressed("jump") and !player.is_on_floor():
			player.velocity.y = player.jump_velocity
