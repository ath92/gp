#version 120
#extension GL_EXT_gpu_shader4 : enable
#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect posTex;
uniform sampler2DRect velTex;
uniform vec2 screen;
uniform vec2 screenPos;

void main() {
    // use the texture coordinates as an index into the position texture
    vec2 verPos = gl_MultiTexCoord0.xy;

    // read position data from texture
    vec4 pixPos = texture2DRect( posTex, verPos );
    vec4 pixVel = texture2DRect( velTex, verPos );
    
    vec4 col = gl_Color;
    col.w = length(pixVel.xy*200)+0.3;
    if(col.w > 1.0) col.w = 1.0;

    col.w = 1.0;
    
    pixPos.x += -0.5;
    pixPos.y += -0.5;
    
    pixPos.x *= screen.x;
    pixPos.y *= screen.y;
    
    gl_Position = pixPos;
    gl_FrontColor =  col;
    gl_BackColor = pixVel;
}