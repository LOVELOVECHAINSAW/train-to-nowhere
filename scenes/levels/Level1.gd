extends Node2D

func _ready():
	for npc in get_tree().get_nodes_in_group("npcs"):
		npc.connect("open_door", self, "_on_npc_open_door")

func _on_npc_open_door():
	get_tree().get_nodes_in_group("exit")[0].locked = false
