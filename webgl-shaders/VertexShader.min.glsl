#pragma glslify: getNormalMatrix = require(./chunks/getNormalMatrix.min)
#pragma glslify: inverse = require(./chunks/inverse.min)
#pragma glslify: transpose = require(./chunks/transpose.min)
vec4 applyTransform(vec4 pos) {
mat4 MVMatrix = u_view * u_transform;
pos.x += 1.0;
pos.y -= 1.0;
pos.xyz *= u_size * 0.5;
pos.y *= -1.0;
v_position = (MVMatrix * pos).xyz;
v_eyeVector = (u_resolution * 0.5) - v_position;
pos = u_perspective * MVMatrix * pos;
return pos;
}
#vert_definitions
vec3 calculateOffset(vec3 ID) {
#vert_applications
return vec3(0.0);
}
void main() {
v_textureCoordinate = a_texCoord;
vec3 invertedNormals = a_normals + (u_normals.x < 0.0 ? calculateOffset(u_normals) * 2.0 - 1.0 : vec3(0.0));
invertedNormals.y *= -1.0;
v_normal = transpose(mat3(inverse(u_transform))) * invertedNormals;
vec3 offsetPos = a_pos + calculateOffset(u_positionOffset);
gl_Position = applyTransform(vec4(offsetPos, 1.0));
}
