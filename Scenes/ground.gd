extends Node2D

class_name Ground

signal bird_crashed

@export var speed = -150

@onready var sprite1: Sprite2D = $Ground1/Sprite2D
@onready var sprite2: Sprite2D = $Ground2/Sprite2D

func _ready() -> void:
	sprite2.global_position.x = sprite1.global_position.x + sprite1.texture.get_width()


func _process(delta: float) -> void:
	sprite1.global_position.x += speed * delta
	sprite2.global_position.x += speed * delta
	
	if sprite1.global_position.x < -sprite1.texture.get_width():
		sprite1.global_position.x = sprite2.global_position.x + sprite2.texture.get_width()
		
	if sprite2.global_position.x < -sprite2.texture.get_width():
		sprite2.global_position.x = sprite1.global_position.x + sprite2.texture.get_width()


func stop():
	speed = 0


func _on_body_entered(body: Node2D) -> void:
	bird_crashed.emit()
	stop()
	(body as Bird).stop()
