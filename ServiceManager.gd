extends Node

"Icon made by Freepik from www.flaticon.com"
class_name ServiceManager, "res://icons/ServiceManager.svg"
signal updated
var _requests:Array = []

func _process(_delta):
	if _requests: 
		var front = _requests.pop_front()
		emit_signal("updated", front)

func request(_method:String)->FuncRef:
	var service = FuncRef.new()
	service.set_function(_method)
	_requests.push_back([_method, service])
	return service
