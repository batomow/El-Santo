extends Node

class_name Pool

export (NodePath) var target_path
export (PackedScene) var droplet_blueprint
export (int) var pool_size
export var closed = false
var target #a place to hold the instances, maybe you want it to be separate
var pool := []
var _callback: FuncRef = null

func _ready(): 
	if target_path: 
		target = get_node(target_path)
	for __ in range(pool_size):
		var droplet = droplet_blueprint.instance()
		pool.push_back(droplet)
		if target: 
			target.add_child(droplet)
		else: 
			self.add_child(droplet)

#entity related
func get_droplet(callback:FuncRef): 
	_callback = callback

func _process(_delta): #might need to turn this into a separate thread
	if _callback && pool: 
		var droplet = pool.pop_front()
		_callback.call(droplet)

#droplet related
func _return_to_pool(droplet): 
	pool.push_back(droplet)
