#include "Uniforms.hlsl"
#include "Samplers.hlsl"
#include "Transform.hlsl"
#include "ScreenPos.hlsl"
#include "PostProcess.hlsl"

uniform float2 cDiffuseRGB;

void VS(float4 iPos : POSITION,
    out float2 oScreenPos : TEXCOORD0,
    out float4 oPos : OUTPOSITION)
{
    float4x3 modelMatrix = iModelMatrix;
    float3 worldPos = GetWorldPos(modelMatrix);
    oPos = GetClipPos(worldPos);
    oScreenPos = GetScreenPosPreDiv(oPos);
}

void PS(float2 iScreenPos : TEXCOORD0,
        out float4 oColor : OUTCOLOR0)
{
    float4 finalColor =  Sample2D(DiffMap, iScreenPos);

    finalColor.rg *= cDiffuseRGB.x;
    finalColor.b += cDiffuseRGB.y;

    oColor = finalColor;
}

