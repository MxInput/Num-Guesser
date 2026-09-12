extends Node

var numbers := []
const AMOUNT_TO_GEN := 4

func generate_new_numbers() -> void:
	numbers.clear()
	
	for current_index in AMOUNT_TO_GEN:
		var generated_num := randi_range(0, 9)
		
		numbers.push_back(generated_num)
		
func _on_ready() -> void:
	generate_new_numbers()
