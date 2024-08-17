shader_type canvas_item;
render_mode blend_mix ;

uniform sampler2D tex : hint_screen_texture ;
const vec2 SIZE = vec2(1024);
const vec2 TEX_PIX_SIZE = 1.0/SIZE;

void vertex() {
	VERTEX *= 1.0;
	//for (int x = 0; x < int(SIZE.x); x++)
	//{	for (int y = 0; y < int(SIZE.y); y++)
		//{
			//;
		//}
	//}
}

void fragment(){
	COLOR = texture(tex, UV);
}