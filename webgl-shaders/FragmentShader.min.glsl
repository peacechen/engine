#pragma glslify: applyMaterial = require(./chunks/applyMaterial.min)
#pragma glslify: applyLight = require(./chunks/applyLight.min)
void main() {
vec4 material = u_baseColor.r >= 0.0 ? u_baseColor : applyMaterial(u_baseColor);
bool lightsEnabled = (u_flatShading == 0.0) && (u_numLights > 0.0 || length(u_ambientLight) > 0.0);
vec3 normal = normalize(v_normal);
vec4 glossiness = u_glossiness.x < 0.0 ? applyMaterial(u_glossiness) : u_glossiness;
vec4 color = lightsEnabled ?
applyLight(material, normalize(v_normal), glossiness,
int(u_numLights),
u_ambientLight * u_baseColor.rgb,
normalize(v_eyeVector),
u_lightPosition,
u_lightColor,   
v_position)
: material;
gl_FragColor = color;
gl_FragColor.a *= u_opacity;   
}
