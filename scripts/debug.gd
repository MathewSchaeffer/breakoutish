extends Node

func print_type_of(reference: Variant, debugText: String) -> void:
	print(debugText + "- is type of -" + str(typeof(reference)))
