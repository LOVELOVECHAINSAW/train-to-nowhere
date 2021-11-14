extends Node

var dialogue: Node

func _ready():
	play_dialogue("Dickgirl1") # Example, remove

func play_dialogue(sequence: String) -> void:
	dialogue = Dialogic.start(sequence)

	$Dialogue.add_child(dialogue)
	dialogue.connect("tree_exited", self, "_on_Dialogue_end")

	# Pause player process
	for player in get_tree().get_nodes_in_group("player"):
		player.set_physics_process(false)
		player.set_process_unhandled_input(false)

## Enables the player's processes
func _on_Dialogue_end() -> void:
	for player in get_tree().get_nodes_in_group("player"):
		player.set_physics_process(true)
		player.set_process_unhandled_input(true)
