
#version 330 compatibility

#include "/lib/distort.glsl"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

in vec2 texcoord;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 color = texture2D(
        colortex0,
        texcoord
    );

    float depth = texture2D(
        depthtex0,
        texcoord
    ).r;

    float shadow = 1.0;

    if (depth < 1.0) {
        vec4 clipPosition = vec4(
            texcoord * 2.0 - 1.0,
            depth * 2.0 - 1.0,
            1.0
        );

        vec4 viewPosition =
            gbufferProjectionInverse *
            clipPosition;

        viewPosition /= viewPosition.w;

        vec4 playerPosition =
            gbufferModelViewInverse *
            viewPosition;

        vec4 shadowViewPosition =
            shadowModelView *
            playerPosition;

        vec4 shadowClipPosition =
            shadowProjection *
            shadowViewPosition;

        shadowClipPosition.xyz /=
            shadowClipPosition.w;

        shadowClipPosition.xyz =
            distortShadowClipPos(
                shadowClipPosition.xyz
            );

        shadowClipPosition.z -= 0.001;

        vec3 shadowScreenPosition =
            shadowClipPosition.xyz * 0.5 + 0.5;

        bool insideShadowMap =
            shadowScreenPosition.x >= 0.0 &&
            shadowScreenPosition.x <= 1.0 &&
            shadowScreenPosition.y >= 0.0 &&
            shadowScreenPosition.y <= 1.0 &&
            shadowScreenPosition.z >= 0.0 &&
            shadowScreenPosition.z <= 1.0;

        if (insideShadowMap) {
            float storedDepth = texture2D(
                shadowtex0,
                shadowScreenPosition.xy
            ).r;

            if (
                shadowScreenPosition.z >
                storedDepth
            ) {
                shadow = 0.45;
            }
        }
    }

    color.rgb *= shadow;

    // Cinematic exposure
    color.rgb *= 1.04;

    // Contrast
    color.rgb =
        (color.rgb - 0.5) * 1.08 + 0.5;

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

    fragColor = vec4(
        color.rgb,
        color.a
    );
}
