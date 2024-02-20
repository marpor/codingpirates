# Godot Quick Start - 3D Platformer - Part 2

This guide picks up where Part 1 left off, so if you haven't already completed Part 1, now's the time to do that.

# Tips

* Multi-select (with shift)
* Edit multiple
* Change X/Y/Z for multiple selected nodes

# Ideas

## More levels

* Scene Menu, Save Scene As

![Save Scene As](../assets/save_scene_as.png)

* Press F6 to test the currently active scene

![Run Current Scene](../assets/run_current_scene.png)

* Or right-click on the scene file to make it the Main Scene

![Set as Main Scene](../assets/set_as_main_scene.png)

* Flags change scene (see below)

## 2 or more players that move together

* Try duplicating the player, and make some levels that require careful moves to succeed
* If just one falls down, you loose

Here's an example:

![Two Player Level Example](two_player_level_example.png)

## Adjust player speed/jump power

* There are already properties on the Player node for this

![Player Properties](player_properties.png)

Bonus idea:

* Take a look at player.gd and see if you can figure out how these properties show up here (hint: look for `@export`)

## Flag transport to other scene

* Needs a scene and script for the flag node

  * Click the `Open In Editor` icon
  * Choose `New Inherited`
  * Add an `Area3D` and a `CollisionShape3D` nodes

* Effect: Fly player up/down
* Effect: Camera looks up/down
* Sound, rotation etc.

## Custom platforms ("modelled" in Godot)

TODO
