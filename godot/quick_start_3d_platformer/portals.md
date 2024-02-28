---
title: Portals
---
# {{ page.title }}

Let's see if we can make the flags load another scene, af if the flag is a "portal" that transports the player to the other scene.

First we need a scene and script for the flag node.

* Click the `Open In Editor` icon to the right of the `flag` node

![Open in editor](res/portals/flag_open_in_editor.png)

* Choose `New Inherited`

![New Inherited](res/portals/new_inherited.png)

_This is necessary because we don't actually have a scene for flag yet. It's used directly from the Blender asset._

* Add an `Area3D` child node
* Add a `CollisionShape3D` node under the `Area3D`

![Add ChildNode](res/portals/add_child_node.png)

It should look like this:

![Child Nodes](res/portals/child_nodes.png)

* Select `CollisionShape3D`
* Create a new `CylinderShape3D`

![New CylinderShape3D](res/portals/new_cylindershape3d.png)

* Use the handles to adjust the size so it looks roughly like this:

![Cylinder Sized](res/portals/cylinder_sized.png)

* Add a script on the flag node

![Flag Add Script](res/portals/flag_add_script.png)

* Select the `Area3D` node

* Connect the Area3D `body_entered` signal with the script
 1. Click the `Node` tab
 2. Double-click `body_entered(body: Node3D)` in the list of signals

![Connect Signal](res/portals/connect_signal_1.png)

  3. Press the `Connect` button

* Update the script code to this:

```gdscript
extends Node3D

signal captured
@export_file("*.tscn") var load_scene: String

func _on_area_3d_body_entered(body):
	# Wait a bit to allow the player to "land" on the flag
	await get_tree().create_timer(0.15).timeout

	# Fly up for half a second
	body.gravity = -100
	captured.emit()
	await get_tree().create_timer(0.5).timeout

	if load_scene and get_tree():
		get_tree().change_scene_to_file(load_scene)
```

> You should still see the ![connected Signal](../assets/icon_connected_signal.png) icon in front of `func _on_area_3d_body_entered` after updating the code. Otherwise, go back and check the signals!

* Save the flag scene by pressing Ctrl+S - you can place it in the `objects` directory

* Go back to your "level" scene

We need to replace the Flag node with our _new_ flag Scene.

* Select the flag node
* Press the Instantiate Child Scene button (Ctrl+Shift+A)

![Instantiate Child Scene](res/portals/instantiate_child_scene.png)

 * Find the scene you just created (`flag.tscn`) - be careful to *not* pick the .glb file as that's the one we're trying to replace, and

![Select flag.tscn](res/portals/select_flag_tscn.png)

* Press **Open**

You will now have two flags under each other. That's OK, because this means that our new flag gets the position of the original flag!

![Two Flags](res/portals/two_flags.png)

* Drag the second flag (with the script icon) above the original flag 

It will get renamed to `flag2` to avoid duplicate names.

* Delete the original flag

![One Flag Again](res/portals/one_flag_again.png)

* Select `flag2`

* In the inspector, you now have a new property `Load Scene`

* Press the Folder icon and pick the scene for the level you want to go to

![Load Scene Property](res/portals/load_scene_property.png)

> Now, it's probably a good time to [make more levels](more_levels.md) so this can become a _proper_ game.

* Test your game!

_If you get issues immediately when you start the game, check that you don't have platforms or other objects interfering with your flag's collision cylinder._

_Another way to avoid this problem is to set different Collsion Masks_

If you want to have the player fall down on loading of the target scene:

* Optional: Move *both* the Player and View nodes up in the target scene. Use [multi-select](multi_select.md) to move both at once.