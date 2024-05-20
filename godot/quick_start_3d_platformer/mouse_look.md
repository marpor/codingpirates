---
title: Mouse Look
---
# {{ page.title }}

## Default game controls

Even though you can move your played with WASD and look around with arrow keys, the way the look is organized is a bit different from regular 3rd person games.

If you look at the scene organization and the `view.gd` script, you can notice, that the camera is not actually attached to the player, and the camera position is updated via code

![image](https://github.com/oxeg/codingpirates/assets/2689981/737d4a59-bab9-4337-b1b3-a27bae637208)
*You can see the Camera object is not under the Player object*


```gdscript
func _physics_process(delta):
	
	# Set position and rotation to targets
	
	self.position = self.position.lerp(target.position, delta * 4)
```

With this organization, player's movement directions are always relative to the camera rotation:
- Player's forward direction - `W` key - always points to the direction of the camera
- Player's backward direction - `S` key - always points to the direction opposite of the camera
- Player's left/right directions - `A`/`D` keys - always point left/right from the camera

![image](https://github.com/oxeg/codingpirates/assets/2689981/f5652957-5caf-4f7e-b435-2ff00e894461)

## Delete current camera

First, we need to delete currect camera and everything that's related to it.

1. Delete the `View` and `Camera` objects from the scene

![image](https://github.com/oxeg/codingpirates/assets/2689981/09878fb7-161e-49b3-b9aa-b8d36974295d)

2. Open `player.gd` script and remove all mentions of the `view` reference (remove all the following lines)

```gdscript
...
@export var view: Node3D
...
input = input.rotated(Vector3.UP, view.rotation.y).normalized()

movement_velocity = input * movement_speed * delta
...
```

## Create camera attached to the player

Now we need to create a new camera, that's attached to the player.

1. Open `Player` scene in editor by either clicking "Open in editor button" or right clicking the player and selecting "Open in editor"

![image](https://github.com/oxeg/codingpirates/assets/2689981/fc7b003e-a1e2-41c9-a28d-a8870aa19224)

2. You should see the Player scene in 3D view. On the left side select the `Player` and click plus sign. Find `Node3D` and click `Create`. Name this node `CameraCenter` - this will be the attachment point for the camera

![image](https://github.com/oxeg/codingpirates/assets/2689981/ddd3ea97-b98f-4692-a5d1-e7b36c1a1ffd)

3. Now select the `CameraCenter` and click plus sign. Find `Camera3D` and click `Create`.

![image](https://github.com/oxeg/codingpirates/assets/2689981/2f1703cb-2124-4e5d-94ad-1088ef9dcbde)

4. Select the `Camera3D` and move it a little bit behind the player. Rotate it so it points to the player. And make sure to enable `Current` checkbox

![image](https://github.com/oxeg/codingpirates/assets/2689981/fdb3ee63-e2b6-41f9-8ebc-bc37ce5634e6)
*You can use these camera Position and Rotation values as an example*

## Updating player controls

We have camera attached to the player, now we need to update the controls and enable mouse look.

First, let's create a new input action, that will allow us ot use mouse look only with right mouse pressed.

1. Open `Project` -> `Project settings` and switch to the `Input Map` tab

![image](https://github.com/oxeg/codingpirates/assets/2689981/62a28937-254b-4b3c-af0c-5a078c728cdc)

2. In the `Add new action` field type `mouse_look_activated` and click `Add` button

![image](https://github.com/oxeg/codingpirates/assets/2689981/fa767b9d-4274-4287-b3e6-8785f76f5498)

3. Scroll down to the new `mouse_look_activated`, click the Plus sign and select `Mouse Buttons` -> `Mouse Right Button`

![image](https://github.com/oxeg/codingpirates/assets/2689981/d3c0bd77-0694-4781-a9fb-3da5a819dd53)

Then let's open the `player.gd` script and do some changes.

1. Add some movement properties to the `Properties` section (`movement_speed` and `mouse_sensivity`)

```gdscript
@export_subgroup("Properties")
@export var movement_speed = 5
@export var mouse_sensitivity = 1000
@export var jump_strength = 7
```

2. Let's cleanup the `_physics_process` function

```gdscript
func _physics_process(delta):
	
	# Handle functions
	
	handle_controls(delta)
	handle_gravity(delta)
	
	handle_effects()
	
	# Falling/respawning
	
	if position.y < -10:
		get_tree().reload_current_scene()
	
	# Animation for scale (jumping and landing)
	
	model.scale = model.scale.lerp(Vector3(1, 1, 1), delta * 10)
	
	# Animation when landing
	
	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)
		Audio.play("res://sounds/land.ogg")
	
	previously_floored = is_on_floor()
```

3. Everything related to the player movement will be in the `handle_controls` function

```gdscript
func handle_controls(delta):
	# Jumping
	
	if Input.is_action_just_pressed("jump"):
		if jump_single or jump_double:
			Audio.play("res://sounds/jump.ogg")
		
		if jump_double:
			gravity = -jump_strength
			
			jump_double = false
			model.scale = Vector3(0.5, 1.5, 0.5)
			
		if(jump_single): jump()
	
	# Movement

	var applied_velocity: Vector3
	var move_forward = Input.get_axis("move_back", "move_forward")
	applied_velocity += transform.basis.z * move_forward * movement_speed
	
	var move_sideways = Input.get_axis("move_right", "move_left")
	applied_velocity += transform.basis.x * move_sideways * movement_speed
	
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide()
```

4. For the player rotation and mouse look let's create an `input` function

```gdscript
# Mouse Look
func _input(event):
	if not Input.is_action_pressed("mouse_look_activated"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouse_sensitivity
		
		$CameraCenter.rotation.x += event.relative.y / mouse_sensitivity
```

4. Now if you click Save and Play - you should be able to play the game using WASD for movement and mouse look with Right Mouse Button pressed

## Full content of the player script

If you have any issues or errors, below you can find full `player.gd` script content

<details>
  <summary>player script</summary>

  ```gdscript
extends CharacterBody3D

signal coin_collected

@export_subgroup("Components")
@export var view: Node3D

@export_subgroup("Properties")
@export var movement_speed = 5
@export var mouse_sensitivity = 1000
@export var jump_strength = 7

var movement_velocity: Vector3
var rotation_direction: float
var gravity = 0

var previously_floored = false

var jump_single = true
var jump_double = true

var coins = 0

@onready var particles_trail = $ParticlesTrail
@onready var sound_footsteps = $SoundFootsteps
@onready var model = $Character
@onready var animation = $Character/AnimationPlayer

# Functions

func _physics_process(delta):
	
	# Handle functions
	
	handle_controls(delta)
	handle_gravity(delta)
	
	handle_effects()
	
	# Falling/respawning
	
	if position.y < -10:
		get_tree().reload_current_scene()
	
	# Animation for scale (jumping and landing)
	
	model.scale = model.scale.lerp(Vector3(1, 1, 1), delta * 10)
	
	# Animation when landing
	
	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)
		Audio.play("res://sounds/land.ogg")
	
	previously_floored = is_on_floor()

# Handle animation(s)

func handle_effects():
	
	particles_trail.emitting = false
	sound_footsteps.stream_paused = true
	
	if is_on_floor():
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			animation.play("walk", 0.5)
			particles_trail.emitting = true
			sound_footsteps.stream_paused = false
		else:
			animation.play("idle", 0.5)
	else:
		animation.play("jump", 0.5)

# Handle movement input

func handle_controls(delta):
	# Jumping
	
	if Input.is_action_just_pressed("jump"):
		if jump_single or jump_double:
			Audio.play("res://sounds/jump.ogg")
		
		if jump_double:
			gravity = -jump_strength
			
			jump_double = false
			model.scale = Vector3(0.5, 1.5, 0.5)
			
		if(jump_single): jump()
	
	# Movement

	var applied_velocity: Vector3
	var move_forward = Input.get_axis("move_back", "move_forward")
	applied_velocity += transform.basis.z * move_forward * movement_speed
	
	var move_sideways = Input.get_axis("move_right", "move_left")
	applied_velocity += transform.basis.x * move_sideways * movement_speed
	
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide()


# Mouse Look
func _input(event):
	if not Input.is_action_pressed("mouse_look_activated"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouse_sensitivity
		
		$CameraCenter.rotation.x += event.relative.y / mouse_sensitivity

# Handle gravity
func handle_gravity(delta):
	
	gravity += 25 * delta
	
	if gravity > 0 and is_on_floor():
		
		jump_single = true
		gravity = 0

# Jumping

func jump():
	
	gravity = -jump_strength
	
	model.scale = Vector3(0.5, 1.5, 0.5)
	
	jump_single = false;
	jump_double = true;

# Collecting coins

func collect_coin():
	
	coins += 1
	
	coin_collected.emit(coins)

  ```
</details>
