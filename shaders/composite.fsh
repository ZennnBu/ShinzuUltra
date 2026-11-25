
#version 120

uniform sampler2D colortex0;

varying vec2 texcoord;

void main() {
    vec4 color = texture2D(
        colortex0,
        texcoord
    );

    // Cinematic exposure
    color.rgb *= 1.04;

    // Contrast
    color.rgb = (color.rgb - 0.5) * 1.08 + 0.5;

    // Richer colors
    float luminance = dot(
        color.rgb,
        vec3(0.299, 0.587, 0.114)
    );

    color.rgb = mix(
        vec3(luminance),
        color.rgb,
        1.08
    );

    color.rgb = clamp(
        color.rgb,
        0.0,
        1.0
    );

    gl_FragColor = vec4(
        color.rgb,
        color.a
    );
}
