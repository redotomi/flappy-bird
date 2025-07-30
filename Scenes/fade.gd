extends Node

class_name Fade

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func play():
	animation_player.play("fade")


func _ready() -> void:
	color_rect.color.a = 0.0


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
