extends CharacterBody2D

@onready var anim: AnimationPlayer = $Sprite/AnimationPlayer
@onready var sprite: Sprite2D = $Sprite

const SPEED = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MoveTimer.start(randf_range(4,9))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	move_and_slide()

func _on_move_timer_timeout() -> void:
	$MoveTimer.set_wait_time(randf_range(4,9))
	var num :int = randi_range(0,4)
	match num:
		0:
			velocity.x = SPEED
			velocity.y = 0
			anim.play("hopping")
			sprite.flip_h = false
		1:
			anim.play("idle")
			velocity.x = 0
			velocity.y = 0
		2:
			velocity.x = -SPEED
			velocity.y = 0
			anim.play("hopping")
			sprite.flip_h = true
		3:
			velocity.x = 0
			velocity.y = SPEED
			anim.play("hopping")
			sprite.flip_h = false
		4:
			velocity.x = 0
			velocity.y = -SPEED
			anim.play("hopping")
			sprite.flip_h = false
