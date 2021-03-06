extends Node

class_name Pool

export (PackedScene) var item_blueprint
export (String) var service_posfix
export (int) var pool_size
export var closed = false
var _pool := []
var _requests := []

var _semaphore_producer = Semaphore.new()
var _semaphore_consumer = Semaphore.new()
var _mutex_producer = Mutex.new() 
var _mutex_consumer = Mutex.new() 
var _thread = Thread.new()

func _ready(): 
	SERVICEMANAGER.register('provide_' + service_posfix, funcref(self, "provide_item"))
	SERVICEMANAGER.register('request_' + service_posfix, funcref(self, "request_item"))
	for __ in range(pool_size): 
		var item = item_blueprint.instance()
		item.position = item.original_position
		self.add_child(item)
		_pool.push_back(item)
		_semaphore_producer.post()

	_thread.start(self, "_serve_requests", null, 0)

func _serve_requests(_userdata): 
	while not closed:
		_semaphore_producer.wait()
		_mutex_producer.lock()
		var item = _pool.pop_front()
		_mutex_producer.unlock()

		_semaphore_consumer.wait()
		_mutex_consumer.lock()
		var request = _requests.pop_front()
		_mutex_consumer.unlock()

		request.call_func(item)


func request_item(callback:FuncRef): 
	_mutex_consumer.lock()
	_requests.push_back(callback)
	_mutex_consumer.unlock()
	_semaphore_consumer.post()

func provide_item(item:Object): 
	_mutex_producer.lock()
	_pool.push_back(item)
	_mutex_producer.unlock()
	_semaphore_producer.post()

func _exit_tree():
	_thread.wait_to_finish()
