class TgSilhouetteComponent extends PrimitiveComponent
    native
    hidecategories(Object)
    config(Engine);

var () bool bEnabled;
var bool bUseFadeOutAlpha;
var () bool bNegativeSilhouette;
var bool bUseThicknessMultiplier;
var () LinearColor SilhouetteColor;
var () float NearThickness;
var () float FarThickness;
var () float NearDistance;
var () float FarDistance;
var export editinline MeshComponent MeshComponent;
var float NearDistanceSq;
var float FarDistanceSq;
var () float FadeOutTime;
var float RemainingFadeOutTime;
var () int PrimitiveSceneInfoId;
var float ThicknessMultiplier;
var native const Pointer ReleaseResourcesFence;

native function SetEnabled(bool bInEnabled);  // Export UTgSilhouetteComponent::execSetEnabled(FFrame&, void* const)

native function SetNegative(bool bNegative);  // Export UTgSilhouetteComponent::execSetNegative(FFrame&, void* const)

native function SetDistance(float InNearDistance, float InFarDistance);  // Export UTgSilhouetteComponent::execSetDistance(FFrame&, void* const)

defaultproperties
{
    bUseFadeOutAlpha=true
    SilhouetteColor=(R=0.8100000,G=0.0500000,B=0.0500000,A=1.0000000)
    NearThickness=0.1000000
    FarThickness=0.2000000
    NearDistance=240.0000000
    FarDistance=1600.0000000
    FadeOutTime=0.3500000
    PrimitiveSceneInfoId=-1
    ReplacementPrimitive=none
    DepthPriorityGroup=SDPG_Middleground
}
