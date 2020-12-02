extends Node

"Icon made by Freepik from www.flaticon.com"
class_name ServiceManager #, "res://icons/ServiceManager.svg"
var services = {}

func register(service_name:String, callback:FuncRef): 
	if services.has(service_name): 
		printerr("service: '", service_name, "' already registered!")
	else: 
		services[service_name] = callback

func request(service_name:String): 
	assert (services.has(service_name))
	return services[service_name]

func check_for_service(service_name:String):
	return services.has(service_name)