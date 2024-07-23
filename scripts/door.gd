extends Area2D

@onready var anim := $AnimatedSprite2D
@onready var collision := $CollisionShape2D

func _on_area_entered(_area :Area2D) -> void:
	anim.play("door_open")
	$Door_Open.play()

func _on_area_exited(_area :Area2D) -> void:
	anim.play("door_closed")
	$Door_Close.play()
