
#version 330 compatibility

uniform sampler2D texture;
uniform sampler2D lightmap;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* DRAWBUFFERS:0 */

void main() {
    vec4 baseColor = texture2D(
        texture,
        texcoord
    );

    vec4 entityColor = baseColor * glcolor;

    vec3 lightColor = texture2D(
        lightmap,
        lmcoord
    ).rgb;

    entityColor.rgb *= lightColor;

    if (entityColor.a < 0.1) {
        discard;
    }

    gl_FragData[0] = entityColor;
}
