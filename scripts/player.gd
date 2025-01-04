class_name Player extends CharacterBody2D

@onready var sprite :Sprite2D = $PlayerSprite
@onready var anim := $PlayerSprite/PlayerAnimation
@onready var bang_anim := $Bang/AnimationPlayer
@onready var pop_up_box :Control = $PlayerSprite/PopupBox
@onready var circle: TextureProgressBar = $CircleBar
@onready var popup_button: Button = $PlayerSprite/PopupButton

@onready var grabbed_interactions :Array = []
@onready var interactlabel := $InteractLabel
@onready var state_label: Label = $PlayerState
@onready var player_items :Array = []


const balloon1 = "res://systems/dialogue_system/dialog/balloon.tscn"
const balloon2 = "res://systems/dialogue_system/dialog/balloon2.tscn"

const SPEED = 65
const SKIP_MODIFIER := 20

var player_state :String
var player_is_interacting :bool = false
var direction :String
var target := position
var tile_selector :Vector2
var frame_num :int = 0

var cooldown_timer :bool = false
#Player textures depending on what is equipped
var player_base :Texture2D = preload("res://art/player/player_base.png")
var player_shovel :Texture2D = preload("res://art/player/player_shovel.png")
var player_backpack :Texture2D = preload("res://art/player/player_backpack.png")
var player_bp_sh :Texture2D = preload("res://art/player/player_bp_sh.png")

func _ready() -> void:
	self.visible = true
	PlayerManager.player = self
	circle.hide()

func _physics_process(_delta :float) -> void:
	state_label.text = player_state
	if player_state == "digging":
		return
	if player_state == "punching":
		return
	move_and_slide()
	if Input.is_action_pressed("space") and (velocity.x or velocity.y != 0):
		player_state = "skipping"
	elif velocity.x or velocity.y != 0:
		player_state = "walking"
		
func _unhandled_input(event :InputEvent) -> void:
	if event is InputEventKey or InputEventJoypadButton:
		if Input.get_connected_joypads():
			GlobalData.controller_connected = true
		else: GlobalData.controller_connected = false
		if Input.is_action_just_pressed("stance"):
			if cooldown_timer: return
			if player_state == "stance":
				player_state = "idle"
			else:
				player_state = "stance"
				anim.play("stance")
		if player_state == "stance":
			if Input.is_action_pressed("punch"):
				anim.play("punch")
			if Input.is_action_just_released("punch"):
				if direction == "left":
					sprite.flip_h = true
					velocity.x = -400
				else:
					sprite.flip_h = false
					velocity.x = 400
					#move_and_slide()
				anim.play("punch_end")
				sprite.self_modulate = Color8(255,255,255,200)
				
				await get_tree().create_timer(0.05).timeout
				velocity.x = 0
				sprite.self_modulate = Color8(255,255,255,255)
				print("punch end")
				$Sounds/Punch.play()
				
				await get_tree().create_timer(0.5).timeout
				anim.play("idle_side")
				start_circle_timer()
		if player_state == "digging":
			return
		if player_state == "sleeping":
			return
		#if Input.is_action_just_pressed("interact"):
			#if not player_is_interacting and not pop_up_box.is_popup_open:
				#execute_interaction()
			##await get_tree().create_timer(0.5).timeout
		if Input.is_action_just_pressed("tool"):
			if player_items.has("Shovel"):
				player_state = "digging"
				match direction:
					"right":
						sprite.flip_h = false
					"left":
						sprite.flip_h = true
					"up":
						sprite.flip_h = false
					"down":
						sprite.flip_h = false
				anim.play("dig_side")
				await anim.animation_finished
				anim.play("dig_side_end")
				$Sounds/Shovel.play()
				print(self.global_position)
				%GameManager.dig_position(%GameManager.update_tile_selector(self.global_position + tile_selector))
				await anim.animation_finished
				player_state = "idle"
					
		if Input.is_action_just_pressed("space"): $Sounds/Skip2.play()
		
		if Input.is_action_pressed("left"):
			sprite.flip_h = true
			if Input.is_action_pressed("space"):
				velocity.x = -SPEED - SKIP_MODIFIER
				velocity.y = 0
				anim.play("skip_side")
			else:
				velocity.x = -SPEED
				velocity.y = 0
				anim.play("walk_side")
			direction = "left"
			$Direction.set_rotation_degrees(180)
		elif Input.is_action_pressed("right"):
			sprite.flip_h = false
			if Input.is_action_pressed("space"):
				velocity.x = SPEED + SKIP_MODIFIER
				velocity.y = 0
				anim.play("skip_side")
			else:
				velocity.x = SPEED
				velocity.y = 0
				anim.play("walk_side")
			direction = "right"
			$Direction.set_rotation_degrees(0)
		elif Input.is_action_pressed("up"):
			sprite.flip_h = false
			velocity.x = 0
			velocity.y = -SPEED
			direction = "up"
			$Direction.set_rotation_degrees(270)
			anim.play("walk_back")
		elif Input.is_action_pressed("down"):
			sprite.flip_h = false
			if Input.is_action_pressed("space"):
				velocity.x = 0
				velocity.y = SPEED + SKIP_MODIFIER
				anim.play("skip_front")
			else:
				anim.play("walk_front")
				velocity.x = 0
				velocity.y = SPEED
			direction = "down"
			$Direction.set_rotation_degrees(90)
		else:
			if player_state == "digging": return
			if player_state == "sleeping": return
			player_state = "idle"
			velocity.x = 0
			velocity.y = 0
			match direction:
				"left":
					tile_selector = Vector2(-8,-1)
					sprite.flip_h = true
					anim.play("idle_side")
				"right":
					tile_selector = Vector2(8,-1)
					sprite.flip_h = false
					anim.play("idle_side")
				"up":
					tile_selector = Vector2(0,-5)
					anim.play("idle_back")
				"down":
					tile_selector = Vector2(0,1)
					anim.play("idle_front")
			#Only necessary when the tile selector needs to be seen
			#%GameManager.update_tile_selector(self.global_position + tile_selector)
			
func _on_area_2d_area_entered(area :Area2D) -> void:
	popup_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	grabbed_interactions.insert(0, area)
	#bang_anim.play(&"Bang")
	update_interactions()
	
func _on_area_2d_area_exited(area :Area2D) -> void:
	popup_button.mouse_filter = Control.MOUSE_FILTER_STOP
	grabbed_interactions.erase(area)
	#bang_anim.play(&"No Bang")
	update_interactions()
	
func update_interactions() -> void:
	if grabbed_interactions:
		interactlabel.text = grabbed_interactions[0].interact_name
	else: interactlabel.text = ""
	
func execute_interaction() -> void:
	if player_is_interacting: return
	player_is_interacting = true
	#bang_anim.play(&"No Bang")
	if grabbed_interactions:
		var current_interaction :Interactable = grabbed_interactions[0]
		match current_interaction.interact_type:
			"Dialogue":
				DialogueManager.show_dialogue_balloon(balloon1,current_interaction.dialogue,"main")
				await DialogueManager.dialogue_ended
			"Bed":
				print("Bed")
				print(current_interaction.get_parent().position)
				self.position = current_interaction.get_parent().position + Vector2(12.0,4.0)
				DialogueManager.show_dialogue_balloon(balloon2,current_interaction.dialogue,"main")
				#if GlobalData.dialogue_confirm
				#sleep()
			"Item":
				$Item_Get.set_texture(current_interaction.interact_texture)
				$Item_Get/AnimationPlayer.play("show_image")
				await $Item_Get/AnimationPlayer.animation_finished
				DialogueManager.show_dialogue_balloon(balloon1,current_interaction.dialogue,"main")
				$Sounds/ItemGet.play()
				player_items.insert(0,current_interaction.interact_name)
				current_interaction.remove_interactable()
				await DialogueManager.dialogue_ended
				$Item_Get/AnimationPlayer.play("hide_image")
				print(player_items)
				
			"Fight":
				$PlayerCamera/AnimationPlayer.play("battle_start")
				await $PlayerCamera/AnimationPlayer.animation_finished
				get_tree().change_scene_to_file("res://scenes/battle_scene.tscn")
			_:
				print("No interaction")
		update_items()
	player_is_interacting = false
	
func update_items() -> void:
	if player_items.has("Backpack"):
		sprite.texture = player_backpack
	if player_items.has("Shovel"):
		sprite.texture = player_shovel
	if player_items.has("Shovel") and player_items.has("Backpack"):
		sprite.texture = player_bp_sh

func sleep() -> void:
	player_state = "sleeping"
	$PlayerMenu.hide()
	anim.play("jump_side")
	await anim.animation_finished
	sprite.flip_h = false
	anim.play("sleep")
	$Sounds/Skip1.play()
	$ScreenTransition/ColorRect/AnimationPlayer.play("fade_black")
	end_day()

func exit_sleep() -> void:
	$PlayerMenu.show()
	anim.play("jump_out")
	await anim.animation_finished
	#grabbed_interactions[0].get_parent().enable_collision()
	direction = "right"
	player_state = "idle"
	$Sounds/Skip1.play()

func open_player_inventory() -> void:
	pop_up_box.open()
	pass

func start_circle_timer() -> void:
	circle.show()
	cooldown_timer = true
	$CircleBar/AnimationPlayer.play("refill")
	await $CircleBar/AnimationPlayer.animation_finished
	#await get_tree().create_timer(2).timeout
	cooldown_timer = false
	circle.hide()

func end_day() -> void:
	GlobalData.day_count += 1
