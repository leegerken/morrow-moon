extends CanvasLayer

@onready var anim := $TransitionPlayer

func fade_in() -> void:
	anim.play("Fade In")
