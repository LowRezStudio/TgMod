class LightComponent extends ActorComponent
    abstract
    native(Light)
    noexport;

enum ELightAffectsClassification
{
    LAC_USER_SELECTED,              // 0
    LAC_DYNAMIC_AFFECTING,          // 1
    LAC_STATIC_AFFECTING,           // 2
    LAC_DYNAMIC_AND_STATIC_AFFECTING,// 3
    LAC_MAX                         // 4
};

enum ELightShadowMode
{
    LightShadow_Normal,             // 0
    LightShadow_Modulate,           // 1
    LightShadow_ModulateBetter,     // 2
    LightShadow_MAX                 // 3
};

enum EShadowProjectionTechnique
{
    ShadowProjTech_Default,         // 0
    ShadowProjTech_PCF,             // 1
    ShadowProjTech_VSM,             // 2
    ShadowProjTech_BPCF_Low,        // 3
    ShadowProjTech_BPCF_Medium,     // 4
    ShadowProjTech_BPCF_High,       // 5
    ShadowProjTech_MAX              // 6
};

enum EShadowFilterQuality
{
    SFQ_Low,                        // 0
    SFQ_Medium,                     // 1
    SFQ_High,                       // 2
    SFQ_MAX                         // 3
};

struct LightingChannelContainer
{
    var bool bInitialized;
    var() bool BSP;
    var() bool Static;
    var() bool Dynamic;
    var() bool CompositeDynamic;
    var() bool Skybox;
    var() bool Unnamed_1;
    var() bool Unnamed_2;
    var() bool Unnamed_3;
    var() bool Unnamed_4;
    var() bool Unnamed_5;
    var() bool Unnamed_6;
    var() bool Cinematic_1;
    var() bool Cinematic_2;
    var() bool Cinematic_3;
    var() bool Cinematic_4;
    var() bool Cinematic_5;
    var() bool Cinematic_6;
    var() bool Cinematic_7;
    var() bool Cinematic_8;
    var() bool Cinematic_9;
    var() bool Cinematic_10;
    var() bool Gameplay_1;
    var() bool Gameplay_2;
    var() bool Gameplay_3;
    var() bool Gameplay_4;
    var() bool Crowd;

    structdefaultproperties
    {
        bInitialized=false
        BSP=false
        Static=false
        Dynamic=false
        CompositeDynamic=false
        Skybox=false
        Unnamed_1=false
        Unnamed_2=false
        Unnamed_3=false
        Unnamed_4=false
        Unnamed_5=false
        Unnamed_6=false
        Cinematic_1=false
        Cinematic_2=false
        Cinematic_3=false
        Cinematic_4=false
        Cinematic_5=false
        Cinematic_6=false
        Cinematic_7=false
        Cinematic_8=false
        Cinematic_9=false
        Cinematic_10=false
        Gameplay_1=false
        Gameplay_2=false
        Gameplay_3=false
        Gameplay_4=false
        Crowd=false
    }
};

var private noimport native const transient Pointer SceneInfo;
var native const transient Matrix WorldToLight;
var native const transient Matrix LightToWorld;
var duplicatetransient const Guid LightGuid;
var duplicatetransient const Guid LightmapGuid;
var() interp const float Brightness;
var() interp const Color LightColor;
var() const export editinline LightFunction Function;
var() const bool bEnabled;
var() const bool CastShadows;
var() const bool CastStaticShadows;
var() bool CastDynamicShadows;
var() bool bCastCompositeShadow;
var() bool bAffectCompositeShadowDirection;
var() bool bNonModulatedSelfShadowing;
var() interp bool bSelfShadowOnly;
var bool bAllowPreShadow;
var const bool bForceDynamicLight;
var const bool UseDirectLightMap;
var const bool bHasLightEverBeenBuiltIntoLightMap;
var const bool bCanAffectDynamicPrimitivesOutsideDynamicChannel;
var(LightShafts) bool bRenderLightShafts;
var(ImageReflection) bool bUseImageReflectionSpecular;
var protected const bool bPrecomputedLightingIsValid;
var protected const bool bExplicitlyAssignedLight;
var() bool bAllowCompositingIntoDLE;
var const export editinline LightEnvironmentComponent LightEnvironment;
var() const LightingChannelContainer LightingChannels;
var() const editconst LightComponent.ELightAffectsClassification LightAffectsClassification;
var() LightComponent.ELightShadowMode LightShadowMode;
var() LinearColor ModShadowColor;
var float ModShadowFadeoutTime;
var float ModShadowFadeoutExponent;
var duplicatetransient native const int LightListIndex;
var LightComponent.EShadowProjectionTechnique ShadowProjectionTechnique;
var() LightComponent.EShadowFilterQuality ShadowFilterQuality;
var() int MinShadowResolution;
var() int MaxShadowResolution;
var() int ShadowFadeResolution;
var(LightShafts) float OcclusionDepthRange;
var(LightShafts) interp float BloomScale;
var(LightShafts) float BloomThreshold;
var(LightShafts) float BloomScreenBlendThreshold;
var(LightShafts) interp Color BloomTint;
var(LightShafts) float RadialBlurPercent;
var(LightShafts) interp float OcclusionMaskDarkness;
var(ImageReflection) float ReflectionSpecularBrightness;
var() const Scene.EDetailMode DetailMode;

// Export ULightComponent::execSetEnabled(FFrame&, void* const)
native final function SetEnabled(bool bSetEnabled);

// Export ULightComponent::execSetLightProperties(FFrame&, void* const)
native final function SetLightProperties(optional float NewBrightness = Brightness, optional Color NewLightColor = LightColor, optional LightFunction NewLightFunction = Function);

// Export ULightComponent::execGetOrigin(FFrame&, void* const)
native final function Vector GetOrigin();

// Export ULightComponent::execGetDirection(FFrame&, void* const)
native final function Vector GetDirection();

// Export ULightComponent::execUpdateColorAndBrightness(FFrame&, void* const)
native final function UpdateColorAndBrightness();

// Export ULightComponent::execUpdateLightShaftParameters(FFrame&, void* const)
native final function UpdateLightShaftParameters();

// Export ULightComponent::execSetDetailMode(FFrame&, void* const)
native final function SetDetailMode(Scene.EDetailMode NewDetailMode);

function OnUpdatePropertyBloomScale()
{
    UpdateLightShaftParameters();
    //return;    
}

function OnUpdatePropertyBloomTint()
{
    UpdateLightShaftParameters();
    //return;    
}

function OnUpdatePropertyOcclusionMaskDarkness()
{
    UpdateLightShaftParameters();
    //return;    
}

function OnUpdatePropertyBrightness()
{
    UpdateColorAndBrightness();
    //return;    
}

function OnUpdatePropertyLightColor()
{
    UpdateColorAndBrightness();
    //return;    
}

defaultproperties
{
    Brightness=1.0000000
    LightColor=(R=255,G=255,B=255,A=0)
    bEnabled=true
    CastShadows=true
    CastStaticShadows=true
    CastDynamicShadows=true
    bCastCompositeShadow=true
    bAffectCompositeShadowDirection=true
    bPrecomputedLightingIsValid=true
    bAllowCompositingIntoDLE=true
    LightingChannels=(bInitialized=true,BSP=true,Static=true,Dynamic=true,CompositeDynamic=true,Skybox=false,Unnamed_1=false,Unnamed_2=false,Unnamed_3=false,Unnamed_4=false,Unnamed_5=false,Unnamed_6=false,Cinematic_1=false,Cinematic_2=false,Cinematic_3=false,Cinematic_4=false,Cinematic_5=false,Cinematic_6=false,Cinematic_7=false,Cinematic_8=false,Cinematic_9=false,Cinematic_10=false,Gameplay_1=false,Gameplay_2=false,Gameplay_3=false,Gameplay_4=false,Crowd=false)
    LightShadowMode=ELightShadowMode.LightShadow_Modulate
    ModShadowColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    ModShadowFadeoutExponent=3.0000000
    OcclusionDepthRange=20000.0000000
    BloomScale=2.0000000
    BloomScreenBlendThreshold=1.0000000
    BloomTint=(R=255,G=255,B=255,A=0)
    RadialBlurPercent=100.0000000
    OcclusionMaskDarkness=0.3000000
    ReflectionSpecularBrightness=0.2000000
}