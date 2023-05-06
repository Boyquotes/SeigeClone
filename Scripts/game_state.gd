extends Node

var isPaused : bool = false
var isGameOver : bool = false


func is_game_over() -> bool:
	return isGameOver


func set_game_over(state) -> void:
	self.isGameOver = state
