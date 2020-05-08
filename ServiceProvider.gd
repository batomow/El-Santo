tool
extends Node 
   
"Icon made by Freepik from www.flaticon.com"
class_name ServiceProvider, "res://icons/ServiceProvider.svg"
onready var parent = get_parent()
onready var err = get_node("/root/SERVICEMANAGER").connect("updated", self, "_provide_service")

func _provide_service(request:Array):
	if parent.has_method(request[0]): 
		(request[1] as FuncRef).set_instance(parent)

func _get_configuration_warning():
	if not ProjectSettings.has_method("autload/SERVICEMANAGER"):
		ProjectSettings.set_setting("autoload/SERVICEMANAGER", "*res://El Santo/ServiceManager.gd")
	return "" 