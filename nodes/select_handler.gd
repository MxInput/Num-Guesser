extends Node

@export var num_containers : Control
 
var current_container_index := 0
const NUM_OF_CONTAINERS := 4

func _input(event: InputEvent) -> void:
	if (event.is_action("left")):
		current_container_index -= 1
		
		if (current_container_index < 0):
			current_container_index = NUM_OF_CONTAINERS - 1
	if (event.is_action("right")):
		current_container_index += 1
		
		if (current_container_index >= NUM_OF_CONTAINERS):
			current_container_index = 0
