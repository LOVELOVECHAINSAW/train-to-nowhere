extends Area2D

signal open_door

func _on_NPC_body_entered(body: Node):
	if body.item:
		match body.item.id:
			"apple":
				print("I don't want apple")
			"orange":
				print("I don't want orange")
			"blueberry":
				print("Exactly what I want!")
				emit_signal("open_door")
			_:
				print("What's that ?")
	else:
		print("Who are you ?")
