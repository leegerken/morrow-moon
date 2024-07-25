extends CharacterBody2D

@onready var anim := $AnimatedSprite2D
@onready var bang_anim := $Bang/AnimationPlayer

const SPEED = 86
var player_state :String
var direction :String
var target := position

func _physics_process(_delta :float) -> void:
	move_and_slide()

func _unhandled_input(_event :InputEvent) -> void:
	if velocity.x or velocity.y != 0:
		player_state = "walking"
	if Input.is_action_pressed("left"):
		anim.flip_h = true
		velocity.x = -SPEED
		velocity.y = 0
		direction = "left"
		$Direction.set_rotation_degrees(180)
		anim.play("walk_side")
	elif Input.is_action_pressed("right"):
		anim.flip_h = false
		velocity.x = SPEED
		velocity.y = 0
		direction = "right"
		$Direction.set_rotation_degrees(0)
		#$Collision.set_rotation_degrees(270)
		anim.play("walk_side")
	elif Input.is_action_pressed("up"):
		anim.flip_h = false
		velocity.x = 0
		velocity.y = -SPEED
		direction = "up"
		$Direction.set_rotation_degrees(270)
		#$Collision.set_rotation_degrees(180)
		anim.play("walk_up")
	elif Input.is_action_pressed("down"):
		anim.flip_h = false
		velocity.x = 0
		velocity.y = SPEED
		direction = "down"
		$Direction.set_rotation_degrees(90)
		anim.play("walk_down")
	else:
		player_state = "idle"
		velocity.x = 0
		velocity.y = 0
		match direction:
			"left": anim.flip_h = true; anim.play("idle_side")
			"right": anim.play("idle_side")
			"up": anim.play("idle_up")
			"down": anim.play("idle_down")
	
	if player_state == "walking":
		match anim.frame:
			1:$Walk1.play()
			4:$Walk2.play()


#func player_movement() -> void:
	#if velocity.x or velocity.y != 0:
		#player_state = "walking"
	#if Input.is_action_pressed("left"):
		#anim.flip_h = true
		#velocity.x = -SPEED
		#velocity.y = 0
		#direction = "left"
		#$Direction.rotation = 0
		#anim.play("walk_side")
	#elif Input.is_action_pressed("right"):
		#anim.flip_h = false
		#velocity.x = SPEED
		#velocity.y = 0
		#direction = "right"
		#$Direction.rotation = 0
		#anim.play("walk_side")
	#elif Input.is_action_pressed("up"):
		#anim.flip_h = false
		#velocity.x = 0
		#velocity.y = -SPEED
		#direction = "up"
		#$Direction.rotation = -1.5708
		#anim.play("walk_up")
	#elif Input.is_action_pressed("down"):
		#anim.flip_h = false
		#velocity.x = 0
		#velocity.y = SPEED
		#direction = "down"
		#$Direction.rotation = 1.5708
		#anim.play("walk_down")
	#else:
		#player_state = "idle"
		#velocity.x = 0
		#velocity.y = 0
		#match direction:
			#"left": anim.flip_h = true; anim.play("idle_side")
			#"right": anim.play("idle_side")
			#"up": anim.play("idle_up")
			#"down": anim.play("idle_down")
	#move_and_slide()
	#if player_state == "walking":
		#match anim.frame:
			#1:$Walk1.play()
			#4:$Walk2.play()
	
func _on_area_2d_area_entered(area :Area2D) -> void:
	print(area)
	bang_anim.play("Bang")

func _on_area_2d_area_exited(_area :Area2D) -> void:
	bang_anim.play("No Bang")
