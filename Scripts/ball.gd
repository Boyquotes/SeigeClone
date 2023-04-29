extends CharacterBody3D
class_name ball

var _is_falling : bool = false
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if _is_falling:
		drop_ball(delta)


## uses physics + gravity to drop player down
func drop_ball(delta) -> void:
	velocity.y -= _gravity * delta
	move_and_slide()


#TODO: ask someone about using setget vs manually creating setter & getter funcs
func is_falling() -> bool:
	return _is_falling


func set_falling(state : bool) -> void:
	_is_falling = state
