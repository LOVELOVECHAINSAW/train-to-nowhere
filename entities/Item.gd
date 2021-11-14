extends Area2D

onready var sprite: Sprite = $Sprite

export(String) var id: String = ""

func _on_Item_body_entered(body: Node):
	if body.is_in_group("player"):
		disconnect("body_entered", self, "_on_Item_body_entered")
		get_parent().call_deferred("remove_child", self)
		body.set_item(self)


func _on_Item_body_exited(_body):
# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_Item_body_entered")
	disconnect("body_exited", self, "_on_Item_body_exited")
