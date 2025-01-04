extends Node

const INVENTORY_DATA :InventoryData = preload("res://items/player_inventory.tres")
var player :Player

func sleep() -> void:
	player.sleep()

func execute_interaction() -> void:
	player.execute_interaction()
