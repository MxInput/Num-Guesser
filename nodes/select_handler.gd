extends Node

@export var num_containers : Control
 
var current_container_index := 0
const NUM_OF_CONTAINERS := 4

@export var default_color : Color;
@export var selected_color : Color;

@export var delay : Timer


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var typed_event = event as InputEventKey;
		var representation : String = PackedByteArray([typed_event.unicode]).get_string_from_utf8();
		
		if (representation.is_valid_int()):
			var current_container = num_containers.get_children()[current_container_index]
			current_container.get_child(0).text = representation
			
	if (event.is_action("left")):
		if (delay.is_stopped()):
			delay.start()
			
			var current_container = num_containers.get_children()[current_container_index]
			current_container.color = default_color
			
			current_container_index -= 1
			
			if (current_container_index < 0):
				current_container_index = NUM_OF_CONTAINERS - 1
				
			var new_container = num_containers.get_children()[current_container_index]
			new_container.color = selected_color
	if (event.is_action("right")):
		if (delay.is_stopped()):
			delay.start()
			
			var current_container = num_containers.get_children()[current_container_index]
			current_container.color = default_color
			
			current_container_index += 1
			
			if (current_container_index >= NUM_OF_CONTAINERS):
				current_container_index = 0
				
			var new_container = num_containers.get_children()[current_container_index]
			new_container.color = selected_color
		
