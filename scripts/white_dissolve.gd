extends TextureRect

var shader_value = material.get_shader_parameter("sensitivity")
var speed = 0.005

func _ready() -> void:
	material.set_shader_parameter("sensitivity",0)

func _physics_process(delta: float) -> void:
	print(shader_value)
	shader_value += speed
	shader_value = clamp(shader_value,0.0,1.0)
	material.set_shader_parameter("sensitivity",shader_value)
