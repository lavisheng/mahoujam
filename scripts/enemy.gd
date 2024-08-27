extends CharacterBody2D

@export_subgroup("Nodes")
@export var gravity_component: GravityComponent
@export var health_component: HealthComponent


func _physics_process(delta):
	gravity_component.handle_gravity(self, false, delta)
	move_and_collide(self.velocity * delta)
