extends Node2D

func _ready() -> void:
	for npc in get_tree().get_nodes_in_group("npcs"):
		npc.connect("open_door", self, "_on_npc_open_door")

## Unlocks exit door
func _on_npc_open_door() -> void:
	get_tree().get_nodes_in_group("exit")[0].locked = false
