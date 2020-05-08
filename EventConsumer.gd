tool
extends Node

"Icon made by Freepik from www.flaticon.com"
class_name EventConsumer, "res://icons/EventConsumer.svg"

func _ready():
	#warning-ignore:unused_variable
	get_node("/root/EVENTMANAGER").connect("updated", get_parent(), "_consume_event")

func _get_configuration_warning():
	if not ProjectSettings.has_method("autoload/EVENTMANAGER"): 
		ProjectSettings.set_setting("autoload/EVENTMANAGER", "*res://El Santo/EventManager.gd")
	if not (get_parent().has_method("_consume_event")):
		return "Parent doesn't implement '_consume_event(event:int)->void' method"
	return "" 