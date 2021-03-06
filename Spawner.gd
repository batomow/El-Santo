extends Position2D

"Icon made by Freepik from www.flaticon.com"
class_name Spawner, "res://El-Santo/icons/Spawner.svg"

export (bool) var is_root = false

enum TAG {ENEMY, ITEM}

export (PackedScene) var scene: PackedScene
export (NodePath) var container_path: String 
signal loaded

func _ready():
	update_configuration_warning()
	if is_root: 
		self.position = Vector2(0,0)

func spawn()->void: 
	var spawns:Array = self.get_children()
	var container: Node = get_node(container_path)
	for spawn in spawns: 
		if spawn.has_method("_load_scene"):
			(spawn as Spawner).scene = self.scene
			(spawn as Spawner)._load_scene(container)
	emit_signal("loaded")

func _load_scene(container: Node)->void: 
	var new_instance = scene.instance() as Node2D
	container.add_child(new_instance)
	new_instance.position = self.position

func _get_configuration_warning():
	if is_root: 
		if not container_path:
			return "Container Path is required for spawner root"
	return ""
