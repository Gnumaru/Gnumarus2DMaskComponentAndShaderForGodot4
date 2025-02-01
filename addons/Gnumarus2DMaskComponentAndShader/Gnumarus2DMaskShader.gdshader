shader_type canvas_item;

uniform bool m_disable = false;
uniform float m_rotation = 0.0;
uniform vec2 m_position = vec2(0.0,0.0);
//uniform vec2 v_viewport_aspect_ratio = vec2(1.0,1.0);
uniform vec2 m_viewport_size = vec2(1.0,1.0);
uniform vec2 m_scale = vec2(1.0,1.0);
uniform sampler2D m_mask_texture;
//uniform vec2 v_masked_texture_size = vec2(1.0,1.0);
//uniform vec2 v_mask_texture_size = vec2(1.0,1.0);

vec2 rotate_uv(vec2 puv, vec2 ppivot, float protation) {
    float vcosa = cos(protation);
    float vsina = sin(protation);
    puv -= ppivot;
    return vec2(
        vcosa * puv.x - vsina * puv.y,
        vcosa * puv.y + vsina * puv.x 
    ) + ppivot;
}

vec2 scale_uv(vec2 p_uv, vec2 p_proportion, vec2 p_scale){
	p_uv -= vec2(0.5,0.5);
	p_uv /= p_proportion * p_scale;
	p_uv += vec2(0.5,0.5);
	return p_uv;
}

void fragment() {
	if(!m_disable){
		vec2 v_mask_uv = UV;
		vec2 v_masked_texture_size = vec2(textureSize(TEXTURE, 0));
		vec2 v_mask_texture_size = vec2(textureSize(m_mask_texture, 0));
		vec2 v_mask_to_parent_proportion = v_mask_texture_size / v_masked_texture_size;
		
		float v_viewport_min_side_size = min(m_viewport_size.x, m_viewport_size.y);
		vec2 v_viewport_aspect_ratio = m_viewport_size / vec2(v_viewport_min_side_size, v_viewport_min_side_size);
		
		float v_mask_y_to_viewport_y_proportion = m_viewport_size.y / v_mask_texture_size.y;
		
		vec2 v_offset = v_mask_to_parent_proportion * SCREEN_PIXEL_SIZE * m_position * v_viewport_aspect_ratio * v_mask_y_to_viewport_y_proportion;
		
		v_mask_uv -= v_offset;
		v_mask_uv = rotate_uv(v_mask_uv, vec2(0.5,0.5), -m_rotation);
		
		v_mask_uv = scale_uv(v_mask_uv, v_mask_to_parent_proportion, m_scale);
		
		vec4 v_mask_color = texture(m_mask_texture, v_mask_uv);
		vec4 v_masked_color = texture(TEXTURE, UV);
		float v_final_alpha = clamp(v_masked_color.a - v_mask_color.a, 0.0, 1.0);
		
		COLOR.rgb = v_masked_color.rgb;
		COLOR.a = v_final_alpha;
	}
}