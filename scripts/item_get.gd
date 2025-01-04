extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var item_texture: TextureRect = $Control/Item_Image/PanelContainer/Item_Texture

func _ready() -> void:
	self.visible = false
	
func set_texture(texture :Texture2D) -> void:
	item_texture.texture = texture 
