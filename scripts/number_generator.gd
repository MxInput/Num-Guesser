extends Node

var numbers := []
const AMOUNT_TO_GEN := 4

@export var default_color : Color;
@export var selected_color : Color;

@export var num_containers : Control

func default_containers() -> void:
	var first = true
	
	for container in num_containers.get_children():
		if (first):
			first = false
			container.color = selected_color
		else:
			container.color = default_color
			
		container.get_child(0).text = ""
	
func generate_new_numbers() -> void:
	default_containers()
	
	numbers.clear()
	
	for current_index in AMOUNT_TO_GEN:
		var generated_num := randi_range(0, 9)
		
		numbers.push_back(generated_num)
		
func _on_ready() -> void:
	generate_new_numbers()
