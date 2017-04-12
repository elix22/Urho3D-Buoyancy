#include "Uniforms.glsl"
#include "Samplers.glsl"
#include "Transform.glsl"
#include "ScreenPos.glsl"

uniform vec2 cDiffuseRGB;
varying vec2 vScreenPos;

void VS()
{
    mat4 modelMatrix = iModelMatrix;
    vec3 worldPos = GetWorldPos(modelMatrix);
    gl_Position = GetClipPos(worldPos);
    vScreenPos = GetScreenPosPreDiv(gl_Position);
}

void PS()
{
    vec4 finalColor =  texture2D(sDiffMap, vScreenPos);

    finalColor.rg *= cDiffuseRGB.x;
    finalColor.b += cDiffuseRGB.y;

    gl_FragColor = finalColor;
}

