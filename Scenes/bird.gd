extends CharacterBody2D

class_name Bird

signal game_started

@export var gravity = 1000.0
@export var jump_force = -350
@export var rotation_speed = 2

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_speed = 400
var is_started = false
var should_process_input = true

func _ready(): 
	velocity = Vector2.ZERO
	animation_player.play("idle")


func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)


func rotate_bird():
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * deg_to_rad(1)
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * deg_to_rad(1)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Jump") && should_process_input:
		if !is_started:
			game_started.emit()
			is_started = true
			animation_player.play("flap_wings")
		jump()
				 
	if !is_started:
		return
	velocity.y += gravity * delta
	
	velocity.y = min(velocity.y, max_speed)
	
	move_and_collide(velocity * delta)
	
	rotate_bird()


func kill():
	should_process_input = false


func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
	should_process_input = false
