extends Node

"Icon made by Freepik from www.flaticon.com"
class_name State, "res://El-Santo/icons/State.svg"

var target: Object = null
var machine: State = null
var previous: State = null
var current: State = null
var next: State 
var states:Dictionary = {}
var substates: Array = [] 

export (int, "root", "machine", "state") var type = 2
export (bool) var reset_on_quit = 1
export (int) var default_node = 0
export (NodePath) var target_path = null

#warning-ignore:unused_signal
#warning-ignore:unused_signal
signal async_execute(method, varargs)
signal async_evaluate(method, varargs)

func _init().(): 
	#warning-ignore:return_value_discarded
	#warning-ignore:return_value_discarded
	self.connect("async_execute", self, "_async_execute", [], CONNECT_DEFERRED | CONNECT_ONESHOT)
	self.connect("async_evaluate", self, "_async_evaluate", [], CONNECT_DEFERRED | CONNECT_ONESHOT)

func reset_async():
	#warning-ignore:return_value_discarded
	#warning-ignore:return_value_discarded
	if not self.is_connected("async_execute", self, "_async_evaluate"):
		self.connect("async_execute", self, "_async_execute", [], CONNECT_DEFERRED | CONNECT_ONESHOT)
	if not self.is_connected("async_evaluate", self, "_async_evaluate"):
		self.connect("async_evaluate", self, "_async_evaluate", [], CONNECT_DEFERRED | CONNECT_ONESHOT)

func _set_target(_target:Object, _machine:State = null):
	target = _target
	machine = _machine
	substates = get_children()
	if substates: 
		next = substates[default_node]
	for state in substates: 
		(state as State)._set_target(target, (self as State))
		states[state.name] = (state as State)

func _ready():
	if type == 0: # if root 
		_set_target(get_node(target_path))

func enter(): 
	pass

func execute(_delta): 
	if current: 
		current.execute(_delta)
	if current != next: 
		switch()
	
func _async_execute(method: FuncRef, varargs=[]):
	yield(method.call_funcv(varargs), "completed")

func evaluate(_delta): 
	if current: 
		current.evaluate(_delta)

func _async_evaluate(method: FuncRef, varargs=[]):
	yield(method.call_funcv(varargs), "completed")

func exit(): 
	if type == 1: 
		stop() 

func stop(): 
	if current:
		current.exit()
	current = null
	if reset_on_quit: 
		if substates: 
			next = substates[default_node]
	

func switch(): 
	if current: 
		current.exit()
	previous = current
	current = next
	if current: 
		current.enter()
