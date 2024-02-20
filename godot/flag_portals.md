## Flags transport to other scene

First we need a scene and script for the flag node.

* Click the `Open In Editor` icon to the right of the `flag` node

![Open in editor](quick_start_3d_platformer_2/flag_open_in_editor.png)

* Choose `New Inherited`

![New Inherited](quick_start_3d_platformer_2/new_inherited.png)

_This is necessary because we don't actually have a scene for flag yet. It's used directly from the Blender asset._

* Add an `Area3D` and a `CollisionShape3D` nodes

* Add the following script on the flag node
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

* Effect: Fly player up/down
* Effect: Camera looks up/down
* Sound, rotation etc.
