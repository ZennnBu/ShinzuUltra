
#version 120

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 vertexColor;
varying vec3 terrainNormal;

void main() {
    gl_Position = ftransform();

    texcoord = gl_MultiTexCoord0.st;
    lmcoord = gl_MultiTexCoord1.st;

    vertexColor = gl_Color;

    terrainNormal = normalize(
        gl_NormalMatrix * gl_Normal
    );
}
