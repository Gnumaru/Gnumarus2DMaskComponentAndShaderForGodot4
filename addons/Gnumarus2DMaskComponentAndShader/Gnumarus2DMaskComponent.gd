@tool
## this component is meant to be used in a sprite that shall be used as a mask to carve holes out of anoter parent sprite2d

class_name Gnumarus2DMaskComponent extends Sprite2D


func _process(_delta: float) -> void:
	var v_masked_sprite:Node = get_parent()

	if not v_masked_sprite is Sprite2D:
		return

	var v_masked_sprite_material:Material = v_masked_sprite.material
	if not v_masked_sprite_material is ShaderMaterial or v_masked_sprite_material.resource_name != "Gnumarus2DMaskShaderMaterial":
		v_masked_sprite.material = load('res://addons/Gnumarus2DMaskComponentAndShader/Gnumarus2DMaskShaderMaterial.tres').duplicate()

	# ensures that the mask itself is not visible
	self_modulate.a = 0.0

	# sets all parameters every frame
	v_masked_sprite_material.set_shader_parameter('m_mask_texture', texture)
	v_masked_sprite_material.set_shader_parameter('m_viewport_size', get_viewport().size)
	v_masked_sprite_material.set_shader_parameter('m_position', position)
	v_masked_sprite_material.set_shader_parameter('m_rotation', rotation)
	v_masked_sprite_material.set_shader_parameter('m_scale', scale)
