
#version 330 compatibility

uniform sampler2D gtexture;

in vec2 texcoord;
in vec4 glcolor;

const int shadowMapResolution = 2048;
const float shadowDistanceRenderMul = 1.0;

layout(location = 0) out vec4 color;

void main() {
    color = texture2D(
        gtexture,
        texcoord
    ) * glcolor;

    if (color.a < 0.1) {
        discard;
    }
}
