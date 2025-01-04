extends CharacterBody2D

@export var health :int = 10

func take_damage() -> void:
	$AnimationPlayer.play("take_damage")
