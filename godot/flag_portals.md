## Flags transport to other scene (aka "Portals")



First we need a scene and script for the flag node.

* Click the `Open In Editor` icon to the right of the `flag` node

![Open in editor](quick_start_3d_platformer_2/flag_open_in_editor.png)

* Choose `New Inherited`

![New Inherited](quick_start_3d_platformer_2/new_inherited.png)

_This is necessary because we don't actually have a scene for flag yet. It's used directly from the Blender asset._

* Add an `Area3D` and a `CollisionShape3D` nodes

![Add ChildNode](flag_portals/add_child_node.png)

![Child Nodes](flag_portals/child_nodes.png)

* Select `CollisionShape3D`
* Create a new `CylinderShape3D`

![New CylinderShape3D](flag_portals/new_cylindershape3d.png)

* Use the handles to adjust the size so it looks roughly like this:

![Cylinder Sized](flag_portals/cylinder_sized.png)


* Add a script on the flag node

![Flag Add Script](flag_portals/flag_add_script.png)

* Update the `Path` to `res://scripts/flag.gd`

* Update the script code to this:

```gdscript
extends Node3D

signal captured
@export_file("*.tscn") var load_scene: String

func _on_area_3d_body_entered(body):
	# Wait a bit to allow the player to "land" on the flag
	await get_tree().create_timer(.15).timeout

	# Fly up for half a second
	body.gravity = -100
	captured.emit()
	await get_tree().create_timer(.5).timeout

	if load_scene and get_tree():
		get_tree().change_scene_to_file(load_scene)
```

* Save the flag scene by pressing Ctrl+S - you can place it in the `objects` directory

* Go back to your "level" scene

* Select the flag

* In the inspector, you now have the ability to pick 

* Effect: Fly player up/down
* Effect: Camera looks up/down
* Sound, rotation etc.
