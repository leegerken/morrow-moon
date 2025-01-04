class_name Interactable extends Area2D
# Defines this as a subclass of Area2D

#INFO
#List of Interactables
#Bed
#Sign,NPC
#Special items
#Fighters

@export var interact_name := "none"
@export var interact_type := "none"
@export var interact_texture :Texture2D
@export var dialogue :DialogueResource

func remove_interactable() -> void:
	get_parent().queue_free()
