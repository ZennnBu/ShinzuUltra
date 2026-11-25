
#version 330

out vec2 texCoord;

void main() {
    gl_Position = vec4(
        (gl_VertexID == 1 || gl_VertexID == 2) ? 3.0 : -1.0,
        (gl_VertexID == 2) ? 3.0 : -1.0,
        0.0,
        1.0
    );

    texCoord = gl_Position.xy * 0.5 + 0.5;
}
