extends Node3D


@onready var _ball_scene = preload("res://Scenes/ball.tscn")
@onready var _map = get_tree().get_root()

@export var _movement_speed : float = 5.0

const _WAIT_TIME : float = 0.5

var _ball_instance : Object


func _ready():
	create_new_ball_instance()


func _process(delta):
	if _ball_instance != null and Input.is_action_just_pressed("drop_ball"):
		drop_ball()
	
	move_player(delta)


## controls player movement
func move_player(delta) -> void:
	if Input.is_action_pressed("move_left"):
		position.x -= _movement_speed * delta
	if Input.is_action_pressed("move_right"):
		position.x += _movement_speed * delta


## creates a new ball instance and adds it to the scene as a child to the player
func create_new_ball_instance() -> void:
	_ball_instance = _ball_scene.instantiate()
	add_child(_ball_instance)


## sets the ball's state to 'falling' and then reparents ball to the map
func drop_ball() -> void:
	_ball_instance.set_falling(true)
	# makes the ball instance not follow the player and drop where the player clicked
	_ball_instance.reparent(_map)
	
#TODO: creating a new ball shouldn't be instant, implement a delay
	# only works if player is not moving
#	await get_tree().create_timer(_WAIT_TIME).timeout
	# creating new one here reduces wait time for next ball
	create_new_ball_instance()


#func wait() -> void:
#	var timer = Timer.new()
#
#	timer.set_wait_time(_WAIT_TIME)
#	timer.set_one_shot(true)
#	add_child(timer)
#	timer.start()
#
#	while not timer.is_stopped():
#		print("waiting")
#		print(timer.time_left)
##	print(timer.is_stopped())	# > false
##	print(timer.wait_time)		# > 10
##	await timer.timeout
##	timer.queue_free()
