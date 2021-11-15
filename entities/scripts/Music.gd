extends Node

var music = AudioStreamPlayer.new()

func _ready():
	music.stream = preload("res://assets/audio/Train to Nowhere.ogg")
	get_tree().root.call_deferred("add_child", music)
	music.play()
	music.volume_db = -20
