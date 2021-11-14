extends "res://entities/scripts/NPC.gd"

func _on_NPC_body_entered(body: Node) -> void:
	if body.item:
		match body.item.id:
			"apple":
				print("I don't want apple")
			"orange":
				print("I don't want orange")
			"blueberry":
				print("Exactly what I want!")
				emit_signal("open_door")
			_: # Default, if none are chosen
				print("What's that ?")
	else:
		print("Who are you ?")
