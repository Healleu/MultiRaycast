class_name MultiRaycast2D extends Node2D

signal colliding(colliders : Array[PhysicsBody2D])

@export var enable : bool = true
@export var collide_with_bodies : bool = true
@export var collide_with_areas : bool = true
@export var hit_from_inside : bool = true
@export_flags_2d_physics var collision_mask : int = 1
@export_range(2, 100, 1) var ray_number : int = 10
@export_range(0, 360, 0.1) var angle : float = 90
@export var length : float = 100.0


var rays : Array[RayCast2D] = []
var colliders : Array[PhysicsBody2D]

func _ready() -> void :
	var delta_angle : float = angle / (ray_number -1)
	var start_angle : float = -angle / 2.0
	var current_angle : float = start_angle
	for index in ray_number :
		var ray : RayCast2D = RayCast2D.new()
		ray.target_position = Vector2(length * cos(deg_to_rad(current_angle)), length * sin(deg_to_rad(current_angle)))
		ray.enabled = enable
		ray.hit_from_inside = hit_from_inside
		ray.collision_mask = collision_mask
		ray.collide_with_bodies = collide_with_bodies
		ray.collide_with_areas = collide_with_areas
		rays.append(ray)
		add_child(ray)
		current_angle += delta_angle
	return


func _process(delta) -> void :
	colliders.clear()
	for ray in rays :
		if ray.is_colliding() :
			var collider = ray.get_collider()
			if colliders.find(collider) == -1 :
				colliders.append(collider)
			if not colliders.is_empty() :
				colliding.emit(colliders)
	return
