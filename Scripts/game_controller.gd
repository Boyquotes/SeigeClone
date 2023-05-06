#
#	TO DO:
#	1) make enemies not spawn on top of one another 
#	2) fix drop ball timer
#
extends Node3D

@onready var _enemy_scene = preload("res://Scenes/enemy.tscn")
@onready var _boundary_scene = preload("res://Scenes/boundary.tscn")
@onready var _boundary = _boundary_scene.instantiate()

@export var MIN_STARTING_ENEMIES : int = 3
@export var MAX_STARTING_ENEMIES : int = 6
@export var _you_lose_UI : CanvasLayer


func _ready():
	var num_of_enemies_to_spawn = randi_range(MIN_STARTING_ENEMIES, MAX_STARTING_ENEMIES)
	
	_boundary.position.x = -5
	add_child(_boundary)
	
	for i in range(num_of_enemies_to_spawn):
		create_enemy()


func _process(delta):
	if GameState.is_game_over():
		_you_lose_UI.show()
		
		if Input.is_action_just_pressed("accept"):
			GameState.set_game_over(false)
			restart_game()


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("restart"):
		restart_game()


## creates a new enemy instance at a random point along the base of the wall
func create_enemy() -> void:
	var enemy_instance = _enemy_scene.instantiate()
	
#TODO: fix enemies spawning on top of one another
	enemy_instance.position.y = 1
	enemy_instance.position.x = _boundary.position.x + (randf() * 10)
	add_child(enemy_instance)


func _on_map_boundary_body_entered(body):
	if body is ball:
		body.queue_free()


func _on_map_boundary_area_entered(area):
	if area.get_parent() is enemy:
		area.get_parent().queue_free()
		create_enemy()


func _on_lose_zone_area_entered(area):
	if area.get_parent() is enemy:
		GameState.set_game_over(true) 
		print("you lose")
		area.get_parent().queue_free()


func restart_game() -> void:
	get_tree().reload_current_scene()
