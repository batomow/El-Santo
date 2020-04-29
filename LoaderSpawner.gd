extends Position2D

class_name LoaderSpawner

enum TYPE {LOADER, SPAWNER}
export (TYPE) var type

enum TAG {ENEMY, ITEM}
export (TAG) var tag

export (NodePath) var spawns_container_path: String 
export (PackedScene) var scene: PackedScene
export (NodePath) var instance_container_path: String 
signal loaded

func spawn()->void: 
    var spawns_container:LoaderSpawner = get_node(spawns_container_path)
    var spawns:Array = spawns_container.get_children()
    var instance_container: Node = get_node(instance_container_path)
    for spawn in spawns: 
        if (spawn as LoaderSpawner).tag == tag: 
            _load_scene(instance_container, spawn.position)
    emit_signal("loaded")

func _load_scene(container: Node, position: Vector2)->void: 
    var new_instance = scene.instance() as Node2D
    container.add_child(new_instance)
    new_instance.position = position
