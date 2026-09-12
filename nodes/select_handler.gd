extends Node

@export var num_containers : Control
 
var current_container_index := 0
const NUM_OF_CONTAINERS := 4

@export var default_color : Color
@export var selected_color : Color

@export var equal_color : Color
@export var greater_color : Color
@export var lesser_color : Color

@export var delay : Timer

@export var num_gen : Node

enum NumStatus {
	GREATER,
	LESSER,
	EQUAL
}

func all_filled() -> bool:
	for found_container in num_containers.get_children():
		if (found_container.get_child(0).text.is_empty()):
			return false
			
	return true
	
func compare_numbers(arr) -> Array:
	var statuses = []
	
	for i in NUM_OF_CONTAINERS:
		var found_container = num_containers.get_children()[i]
		var container_text = found_container.get_child(0).text
		var converted_number = container_text.to_int()
		
		if (converted_number == arr[i]):
			statuses.push_back(NumStatus.EQUAL)
		elif (converted_number < arr[i]):
			statuses.push_back(NumStatus.LESSER)
		else:
			statuses.push_back(NumStatus.GREATER)
			
	return statuses
	
func change_appearance(statuses) -> void:
	var count = 0
	
	for s in statuses:
		var container = num_containers.get_children()[count]
		
		match (s):
			NumStatus.EQUAL:
				container.color = equal_color
				container.get_child(1).text = "="
			NumStatus.GREATER:
				container.color = greater_color
				container.get_child(1).text = ">"
			NumStatus.LESSER:
				container.color = lesser_color
				container.get_child(1).text = "<"
				
		count += 1
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var keycode = DisplayServer.keyboard_get_keycode_from_physical(event.physical_keycode);
		
		if (keycode == Key.KEY_ENTER):
			if (all_filled()):
				var generated_numbers = num_gen.numbers
				
				var statuses = compare_numbers(generated_numbers)
				change_appearance(statuses)
		else:
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
		
