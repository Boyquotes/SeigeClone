extends Node

var _isPaused : bool = false
var _isGameOver : bool = false
var _player_score : int
var _high_score : int = 0


func is_game_over() -> bool:
	return _isGameOver


func set_game_over(state) -> void:
	self._isGameOver = state


func get_player_score() -> int:
	return _player_score


func inc_player_score(val: int) -> void:
	self._player_score += val


func set_player_score(val: int) -> void:
	self._player_score = val

func is_new_high_score() -> bool:
	if _player_score > _high_score:
		_high_score = _player_score
		return true
	
	return false
