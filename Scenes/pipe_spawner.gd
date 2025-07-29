extends Node

class_name PipeSpawner

signal bird_crashed
signal point_scored

var pipes_scene = preload("res://Scenes/pipes.tscn")

@export var pipe_speed = -150

@onready var spawn_timer: Timer = $SpawnTimer


func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is Pipes):
		(pipe as Pipes).speed = 0
	


func on_bird_entered():
	bird_crashed.emit()
	stop()


func on_point_scored():
	point_scored.emit()


func spawn_pipe():
	var pipe = pipes_scene.instantiate() as Pipes
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pipe.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	pipe.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	pipe.bird_entered.connect(on_bird_entered)
	pipe.point_scored.connect(on_point_scored)
	pipe.set_speed(pipe_speed)


func _ready() -> void:
	spawn_timer.timeout.connect(spawn_pipe)
	spawn_timer.start()
