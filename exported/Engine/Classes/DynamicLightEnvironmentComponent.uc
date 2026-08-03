class DynamicLightEnvironmentComponent extends LightEnvironmentComponent
    native(Light);

enum EDynamicLightEnvironmentBoundsMethod
{
    DLEB_OwnerComponents,           // 0
    DLEB_ManualOverride,            // 1
    DLEB_ActiveComponents,          // 2
    DLEB_MAX                        // 3
};

var private native const transient Pointer State;
var() float InvisibleUpdateTime;
var() float MinTimeBetweenFullUpdates;
var float VelocityUpdateTimeScale;
var float ShadowInterpolationSpeed;
var() int NumVolumeVisibilitySamples;
var() float LightingBoundsScale;
var LinearColor AmbientShadowColor;
var Vector AmbientShadowSourceDirection;
var LinearColor AmbientGlow;
var float LightDistance;
var float ShadowDistance;
var() bool bCastShadows;
var bool bCompositeShadowsFromDynamicLights;
var bool bForceCompositeAllLights;
var bool bAffectedBySmallDynamicLights;
var() bool bUseBooleanEnvironmentShadowing;
var bool bShadowFromEnvironment;
var() bool bDynamic;
var bool bSynthesizeDirectionalLight;
var() bool bSynthesizeSHLight;
var() bool bRequiresNonLatentUpdates;
var bool bTraceFromClosestBoundsPoint;
var() bool bIsCharacterLightEnvironment;
var bool bOverrideOwnerLightingChannels;
var bool bAlwaysInfluencedByDominantDirectionalLight;
var float ModShadowFadeoutTime;
var float ModShadowFadeoutExponent;
var LinearColor MaxModulatedShadowColor;
var float DominantShadowTransitionStartDistance;
var float DominantShadowTransitionEndDistance;
var float MinShadowAngle;
var DynamicLightEnvironmentComponent.EDynamicLightEnvironmentBoundsMethod BoundsMethod;
var BoxSphereBounds OverriddenBounds;
var LightingChannelContainer OverriddenLightingChannels;
var const export editinline array<export editinline LightComponent> OverriddenLightComponents;

// Export UDynamicLightEnvironmentComponent::execResetEnvironment(FFrame&, void* const)
native final function ResetEnvironment();

defaultproperties
{
    InvisibleUpdateTime=5.0000000
    MinTimeBetweenFullUpdates=1.0000000
    VelocityUpdateTimeScale=0.0000010
    ShadowInterpolationSpeed=0.0040000
    NumVolumeVisibilitySamples=1
    LightingBoundsScale=1.0000000
    AmbientShadowColor=(R=0.0010000,G=0.0010000,B=0.0010000,A=1.0000000)
    AmbientShadowSourceDirection=(X=0.0100000,Y=0.0000000,Z=0.9900000)
    AmbientGlow=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    LightDistance=10.0000000
    ShadowDistance=5.0000000
    bCastShadows=true
    bCompositeShadowsFromDynamicLights=true
    bAffectedBySmallDynamicLights=true
    bUseBooleanEnvironmentShadowing=true
    bShadowFromEnvironment=true
    bDynamic=true
    bSynthesizeDirectionalLight=true
    ModShadowFadeoutExponent=3.0000000
    MaxModulatedShadowColor=(R=0.5000000,G=0.5000000,B=0.5000000,A=1.0000000)
    DominantShadowTransitionStartDistance=100.0000000
    DominantShadowTransitionEndDistance=10.0000000
    MinShadowAngle=25.0000000
}