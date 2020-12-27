extends Node

"Icon made by Freepik from www.flaticon.com"
class_name ServiceManager #, "res://icons/ServiceManager.svg"
var services = {}
var requests = {}

func register(service_name:String, callback:FuncRef): 
	if service_name in services: 
		printerr("service: '", service_name, "' already registered!")
	else: 
		services[service_name] = callback
		if requests.has(service_name): 
			for req in requests[service_name]: 
				req.call_func(callback)
			requests.erase(service_name)


func request(service_name:String, callback:FuncRef): 
	if not service_name in requests: 
		requests[service_name] = []

	if service_name in services:
		var service = services[service_name]
		callback.call_func(service)
	else: 
		requests[service_name].push_back(callback)
