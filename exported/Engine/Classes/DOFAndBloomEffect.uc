class DOFAndBloomEffect extends DOFEffect
    native
    hidecategories(Object);

enum EDOFType
{
    DOFType_SimpleDOF,              // 0
    DOFType_ReferenceDOF,           // 1
    DOFType_BokehDOF,               // 2
    DOFType_MAX                     // 3
};

enum EDOFQuality
{
    DOFQuality_Low,                 // 0
    DOFQuality_Medium,              // 1
    DOFQuality_High,                // 2
    DOFQuality_MAX                  // 3
};

var(Bloom) float BloomScale;
var(Bloom) float BloomThreshold;
var(Bloom) Color BloomTint;
var(Bloom) float BloomScreenBlendThreshold;
var deprecated float SceneMultiplier;
var(Bloom) float BlurBloomKernelSize;
var deprecated bool bEnableReferenceDOF;
var(DepthOfField) DOFAndBloomEffect.EDOFType DepthOfFieldType;
var(DepthOfField) DOFAndBloomEffect.EDOFQuality DepthOfFieldQuality;
var(DepthOfField) Texture2D BokehTexture;

defaultproperties
{
    BloomScale=1.0000000
    BloomThreshold=1.0000000
    BloomTint=(R=255,G=255,B=255,A=0)
    BloomScreenBlendThreshold=10.0000000
    BlurBloomKernelSize=16.0000000
    BlurKernelSize=16.0000000
}