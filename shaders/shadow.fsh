
#version 330 compatibility

uniform sampler2D texture;

in vec2 texcoord;
in vec4 glcolor;

void main() {
    vec4 color = texture2D(
        texture,
        texcoord
    ) * glcolor;

    if (color.a < 0.1) {
        discard;
    }
}
