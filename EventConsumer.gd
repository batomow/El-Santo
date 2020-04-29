tool
extends Node

class_name EventConsumer

func _ready():
	update_configuration_warning()
	var err = EventManager.connect("updated", get_parent(), "_consume_event")
	if err: 
		printerr("Coudl't subscribe to event manager: {0}" % self.name)

func _get_configuration_warning():
	if not (get_parent().has_method("_consume_event")):
		return "Parent doesn't implement '_consume_event(event:int)->void' method"
	return "" 
