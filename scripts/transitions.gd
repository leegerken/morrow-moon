extends CanvasLayer

@onready var anim := $TransitionPlayer

func _ready() -> void:
	self.visible = true

func fade_in() -> void:
	anim.play("Fade In")
