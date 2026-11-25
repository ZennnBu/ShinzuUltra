
const int shadowMapResolution = 2048;

vec3 distortShadowClipPos(vec3 shadowClipPos) {
    float distortionFactor = length(
        shadowClipPos.xy
    );

    distortionFactor += 0.1;

    shadowClipPos.xy /= distortionFactor;

    // Extend shadow range along the Z axis
    shadowClipPos.z *= 0.5;

    return shadowClipPos;
}
