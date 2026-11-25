
#version 330 compatibility

uniform vec3 skyColor;

in vec4 glcolor;

/* DRAWBUFFERS:0 */

void main() {
    vec3 color = skyColor * glcolor.rgb;

    gl_FragData[0] = vec4(color, 1.0);
}
