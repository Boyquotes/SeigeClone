extends Node3D
class_name enemy

var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var _is_falling : bool = false
var _movement_speed : float = 1.0


func _process(delta):
	# Enemies should still fall even if the game is over.
	if _is_falling:
		drop(delta)
	
	if not GameState.is_game_over():
		climb_wall(delta)


func _on_hurtbox_body_entered(body):
	if body is ball:
#TODO: maybe ball continues to fall to bot, but can't knock anyone else down
		GameState.inc_player_score(1)
		body.queue_free()
	
	_is_falling = true


func drop(delta : float):
	position.y -= 1 * _gravity * delta


func _on_hurtbox_area_entered(area):
	if area.get_parent() is enemy and area.get_parent()._is_falling:
		_is_falling = true
		GameState.inc_player_score(2) # bonus points for combos


func is_falling() -> bool:
	return _is_falling


func climb_wall(delta : float) -> void:
	position.y += _movement_speed * delta
