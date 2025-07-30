extends Node

@onready var bird: Bird = $"../Bird"
@onready var pipe_spawner: PipeSpawner = $"../PipeSpawner"
@onready var ground: Ground = $"../Ground"
@onready var fade: Fade = $"../Fade"
@onready var ui: UI = $"../UI"

var points = 0


func on_game_started():
	pipe_spawner.start_spawning_pipes()


func end_game():
	if fade:
		fade.play()
	ground.stop()
	bird.kill()
	pipe_spawner.stop()
	ui.on_game_over()


func on_point_scored():
	points += 1
	ui.update_points(points)


func _ready() -> void:
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored) 
