extends Area3D

@export var sceneName := "WinScreen"

func _on_Area_Trigger_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
