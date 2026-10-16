class PostProcessVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display,Advanced,Collision,Volume,Brush,Attachment);

struct native LUTBlender
{
    var array<Texture> LUTTextures;
    var array<float> LUTWeights;
    var native const transient bool bHasChanged;

    structdefaultproperties
    {
        LUTTextures=none
        LUTWeights=none
    }
};

struct native MobileColorGradingParams
{
    var() float TransitionTime;
    var() float Blend;
    var() float Desaturation;
    var() LinearColor HighLights;
    var() LinearColor MidTones;
    var() LinearColor Shadows;

    structdefaultproperties
    {
        TransitionTime=1.0000000
        Blend=0.0000000
        Desaturation=0.0000000
        HighLights=(R=0.7000000,G=0.7000000,B=0.7000000,A=1.0000000)
        MidTones=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
        Shadows=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    }
};

struct native MobilePostProcessSettings
{
    var bool bOverride_Mobile_BlurAmount;
    var bool bOverride_Mobile_TransitionTime;
    var bool bOverride_Mobile_Bloom_Scale;
    var bool bOverride_Mobile_Bloom_Threshold;
    var bool bOverride_Mobile_Bloom_Tint;
    var bool bOverride_Mobile_DOF_Distance;
    var bool bOverride_Mobile_DOF_MinRange;
    var bool bOverride_Mobile_DOF_MaxRange;
    var bool bOverride_Mobile_DOF_NearBlurFactor;
    var bool bOverride_Mobile_DOF_FarBlurFactor;
    var() interp float Mobile_BlurAmount;
    var() float Mobile_TransitionTime;
    var(Bloom) interp float Mobile_Bloom_Scale;
    var(Bloom) interp float Mobile_Bloom_Threshold;
    var(Bloom) interp LinearColor Mobile_Bloom_Tint;
    var(DOF) interp float Mobile_DOF_Distance;
    var(DOF) interp float Mobile_DOF_MinRange;
    var(DOF) interp float Mobile_DOF_MaxRange;
    var(DOF) interp float Mobile_DOF_NearBlurFactor;
    var(DOF) interp float Mobile_DOF_FarBlurFactor;

    structdefaultproperties
    {
        bOverride_Mobile_BlurAmount=false
        bOverride_Mobile_TransitionTime=false
        bOverride_Mobile_Bloom_Scale=false
        bOverride_Mobile_Bloom_Threshold=false
        bOverride_Mobile_Bloom_Tint=false
        bOverride_Mobile_DOF_Distance=false
        bOverride_Mobile_DOF_MinRange=false
        bOverride_Mobile_DOF_MaxRange=false
        bOverride_Mobile_DOF_NearBlurFactor=false
        bOverride_Mobile_DOF_FarBlurFactor=false
        Mobile_BlurAmount=16.0000000
        Mobile_TransitionTime=1.0000000
        Mobile_Bloom_Scale=6.0000000
        Mobile_Bloom_Threshold=0.5000000
        Mobile_Bloom_Tint=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000)
        Mobile_DOF_Distance=1500.0000000
        Mobile_DOF_MinRange=600.0000000
        Mobile_DOF_MaxRange=1200.0000000
        Mobile_DOF_NearBlurFactor=1.0000000
        Mobile_DOF_FarBlurFactor=1.0000000
    }
};

struct native PostProcessSettings
{
    var bool bOverride_EnableBloom;
    var bool bOverride_EnableDOF;
    var bool bOverride_EnableMotionBlur;
    var bool bOverride_EnableSceneEffect;
    var bool bOverride_AllowAmbientOcclusion;
    var bool bOverride_OverrideRimShaderColor;
    var bool bOverride_Bloom_Scale;
    var bool bOverride_Bloom_Threshold;
    var bool bOverride_Bloom_Tint;
    var bool bOverride_Bloom_ScreenBlendThreshold;
    var bool bOverride_Bloom_InterpolationDuration;
    var bool bOverride_DOF_FalloffExponent;
    var bool bOverride_DOF_BlurKernelSize;
    var bool bOverride_DOF_BlurBloomKernelSize;
    var bool bOverride_DOF_MaxNearBlurAmount;
    var bool bOverride_DOF_MinBlurAmount;
    var bool bOverride_DOF_MaxFarBlurAmount;
    var bool bOverride_DOF_FocusType;
    var bool bOverride_DOF_FocusInnerRadius;
    var bool bOverride_DOF_FocusDistance;
    var bool bOverride_DOF_FocusPosition;
    var bool bOverride_DOF_InterpolationDuration;
    var bool bOverride_DOF_BokehTexture;
    var bool bOverride_MotionBlur_MaxVelocity;
    var bool bOverride_MotionBlur_Amount;
    var bool bOverride_MotionBlur_FullMotionBlur;
    var bool bOverride_MotionBlur_CameraRotationThreshold;
    var bool bOverride_MotionBlur_CameraTranslationThreshold;
    var bool bOverride_MotionBlur_InterpolationDuration;
    var bool bOverride_Scene_Desaturation;
    var bool bOverride_Scene_Colorize;
    var bool bOverride_Scene_TonemapperScale;
    var bool bOverride_Scene_ImageGrainScale;
    var bool bOverride_Scene_HighLights;
    var bool bOverride_Scene_MidTones;
    var bool bOverride_Scene_Shadows;
    var bool bOverride_Scene_InterpolationDuration;
    var bool bOverride_Scene_ColorGradingLUT;
    var bool bOverride_RimShader_Color;
    var bool bOverride_RimShader_InterpolationDuration;
    var bool bOverride_MobileColorGrading;
    var(Bloom) bool bEnableBloom;
    var(DepthOfField) bool bEnableDOF;
    var(MotionBlur) bool bEnableMotionBlur;
    var(Scene) bool bEnableSceneEffect;
    var() bool bAllowAmbientOcclusion;
    var(RimShader) bool bOverrideRimShaderColor;
    var(Bloom) interp float Bloom_Scale;
    var(Bloom) interp float Bloom_Threshold;
    var(Bloom) interp Color Bloom_Tint;
    var(Bloom) interp float Bloom_ScreenBlendThreshold;
    var(Bloom) float Bloom_InterpolationDuration;
    var(Bloom) interp float DOF_BlurBloomKernelSize;
    var(DepthOfField) interp float DOF_FalloffExponent;
    var(DepthOfField) interp float DOF_BlurKernelSize;
    var(DepthOfField,BlurAmount) interp float DOF_MaxNearBlurAmount;
    var(DepthOfField,BlurAmount) interp float DOF_MinBlurAmount;
    var(DepthOfField,BlurAmount) interp float DOF_MaxFarBlurAmount;
    var(DepthOfField) DOFEffect.EFocusType DOF_FocusType;
    var(DepthOfField) interp float DOF_FocusInnerRadius;
    var(DepthOfField) interp float DOF_FocusDistance;
    var(DepthOfField) Vector DOF_FocusPosition;
    var(DepthOfField) float DOF_InterpolationDuration;
    var(DepthOfField) Texture2D DOF_BokehTexture;
    var(MotionBlur) interp float MotionBlur_MaxVelocity;
    var(MotionBlur) interp float MotionBlur_Amount;
    var(MotionBlur) bool MotionBlur_FullMotionBlur;
    var(MotionBlur) interp float MotionBlur_CameraRotationThreshold;
    var(MotionBlur) interp float MotionBlur_CameraTranslationThreshold;
    var(MotionBlur) float MotionBlur_InterpolationDuration;
    var(Scene) interp float Scene_Desaturation;
    var(Scene) interp Vector Scene_Colorize;
    var(Scene) interp float Scene_TonemapperScale;
    var(Scene) interp float Scene_ImageGrainScale;
    var(Scene) interp Vector Scene_HighLights;
    var(Scene) interp Vector Scene_MidTones;
    var(Scene) interp Vector Scene_Shadows;
    var(Scene) float Scene_InterpolationDuration;
    var(RimShader) LinearColor RimShader_Color;
    var(RimShader) float RimShader_InterpolationDuration;
    var(Scene) Texture ColorGrading_LookupTable;
    var private const transient LUTBlender ColorGradingLUT;
    var(Mobile) MobileColorGradingParams MobileColorGrading;
    var(Mobile) interp MobilePostProcessSettings MobilePostProcess;
    var bool Death_Enable;
    var float Death_DesatAlpha;
    var bool Hit_Enable;
    var float Hit_FadeAlpha;
    var bool ColorBlind_Enable;
    var int ColorBlind_Mode;

    structdefaultproperties
    {
        bOverride_EnableBloom=true
        bOverride_EnableDOF=true
        bOverride_EnableMotionBlur=true
        bOverride_EnableSceneEffect=true
        bOverride_AllowAmbientOcclusion=true
        bOverride_OverrideRimShaderColor=true
        bOverride_Bloom_Scale=true
        bOverride_Bloom_Threshold=true
        bOverride_Bloom_Tint=true
        bOverride_Bloom_ScreenBlendThreshold=true
        bOverride_Bloom_InterpolationDuration=true
        bOverride_DOF_FalloffExponent=true
        bOverride_DOF_BlurKernelSize=true
        bOverride_DOF_BlurBloomKernelSize=true
        bOverride_DOF_MaxNearBlurAmount=true
        bOverride_DOF_MinBlurAmount=false
        bOverride_DOF_MaxFarBlurAmount=true
        bOverride_DOF_FocusType=true
        bOverride_DOF_FocusInnerRadius=true
        bOverride_DOF_FocusDistance=true
        bOverride_DOF_FocusPosition=true
        bOverride_DOF_InterpolationDuration=true
        bOverride_DOF_BokehTexture=false
        bOverride_MotionBlur_MaxVelocity=false
        bOverride_MotionBlur_Amount=false
        bOverride_MotionBlur_FullMotionBlur=false
        bOverride_MotionBlur_CameraRotationThreshold=false
        bOverride_MotionBlur_CameraTranslationThreshold=false
        bOverride_MotionBlur_InterpolationDuration=false
        bOverride_Scene_Desaturation=true
        bOverride_Scene_Colorize=false
        bOverride_Scene_TonemapperScale=false
        bOverride_Scene_ImageGrainScale=false
        bOverride_Scene_HighLights=true
        bOverride_Scene_MidTones=true
        bOverride_Scene_Shadows=true
        bOverride_Scene_InterpolationDuration=true
        bOverride_Scene_ColorGradingLUT=false
        bOverride_RimShader_Color=true
        bOverride_RimShader_InterpolationDuration=true
        bOverride_MobileColorGrading=false
        bEnableBloom=true
        bEnableDOF=false
        bEnableMotionBlur=true
        bEnableSceneEffect=true
        bAllowAmbientOcclusion=true
        bOverrideRimShaderColor=false
        Bloom_Scale=1.0000000
        Bloom_Threshold=1.0000000
        Bloom_Tint=(R=255,G=255,B=255,A=0)
        Bloom_ScreenBlendThreshold=10.0000000
        Bloom_InterpolationDuration=1.0000000
        DOF_BlurBloomKernelSize=16.0000000
        DOF_FalloffExponent=4.0000000
        DOF_BlurKernelSize=16.0000000
        DOF_MaxNearBlurAmount=1.0000000
        DOF_MinBlurAmount=0.0000000
        DOF_MaxFarBlurAmount=1.0000000
        DOF_FocusType=EFocusType.FOCUS_Distance
        DOF_FocusInnerRadius=2000.0000000
        DOF_FocusDistance=0.0000000
        DOF_FocusPosition=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        DOF_InterpolationDuration=1.0000000
        DOF_BokehTexture=none
        MotionBlur_MaxVelocity=1.0000000
        MotionBlur_Amount=0.5000000
        MotionBlur_FullMotionBlur=true
        MotionBlur_CameraRotationThreshold=45.0000000
        MotionBlur_CameraTranslationThreshold=10000.0000000
        MotionBlur_InterpolationDuration=1.0000000
        Scene_Desaturation=0.0000000
        Scene_Colorize=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Scene_TonemapperScale=1.0000000
        Scene_ImageGrainScale=0.0000000
        Scene_HighLights=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Scene_MidTones=(X=1.0000000,Y=1.0000000,Z=1.0000000)
        Scene_Shadows=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Scene_InterpolationDuration=1.0000000
        RimShader_Color=(R=0.4704400,G=0.5859730,B=0.8277260,A=1.0000000)
        RimShader_InterpolationDuration=1.0000000
        ColorGrading_LookupTable=none
        ColorGradingLUT=(LUTTextures=none,LUTWeights=none)
        MobileColorGrading=(TransitionTime=1.0000000,Blend=0.0000000,Desaturation=0.0000000,HighLights=(R=0.7000000,G=0.7000000,B=0.7000000,A=1.0000000),MidTones=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000),Shadows=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000))
        MobilePostProcess=(bOverride_Mobile_BlurAmount=false,bOverride_Mobile_TransitionTime=false,bOverride_Mobile_Bloom_Scale=false,bOverride_Mobile_Bloom_Threshold=false,bOverride_Mobile_Bloom_Tint=false,bOverride_Mobile_DOF_Distance=false,bOverride_Mobile_DOF_MinRange=false,bOverride_Mobile_DOF_MaxRange=false,bOverride_Mobile_DOF_NearBlurFactor=false,bOverride_Mobile_DOF_FarBlurFactor=false,Mobile_BlurAmount=16.0000000,Mobile_TransitionTime=1.0000000,Mobile_Bloom_Scale=6.0000000,Mobile_Bloom_Threshold=0.5000000,Mobile_Bloom_Tint=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000),Mobile_DOF_Distance=1500.0000000,Mobile_DOF_MinRange=600.0000000,Mobile_DOF_MaxRange=1200.0000000,Mobile_DOF_NearBlurFactor=1.0000000,Mobile_DOF_FarBlurFactor=1.0000000)
        Death_Enable=false
        Death_DesatAlpha=0.0000000
        Hit_Enable=false
        Hit_FadeAlpha=0.0000000
        ColorBlind_Enable=false
        ColorBlind_Mode=0
    }
};

var() float Priority;
var() bool bOverrideWorldPostProcessChain;
var() bool bEnabled;
var() PostProcessSettings Settings;
var noimport const transient PostProcessVolume NextLowerPriorityVolume;

replication
{
    // Pos:0x000
    if(bNetDirty)
        bEnabled;
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bEnabled = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bEnabled = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bEnabled = !bEnabled;
            }
        }
    }
    ForceNetRelevant();
    SetForcedInitialReplicatedProperty(BoolProperty'Engine.PostProcessVolume.bEnabled', bEnabled == default.bEnabled);
    //return;    
}

defaultproperties
{
    bEnabled=true
    Settings=(bOverride_EnableBloom=true,bOverride_EnableDOF=true,bOverride_EnableMotionBlur=true,bOverride_EnableSceneEffect=true,bOverride_AllowAmbientOcclusion=true,bOverride_OverrideRimShaderColor=true,bOverride_Bloom_Scale=true,bOverride_Bloom_Threshold=true,bOverride_Bloom_Tint=true,bOverride_Bloom_ScreenBlendThreshold=true,bOverride_Bloom_InterpolationDuration=true,bOverride_DOF_FalloffExponent=true,bOverride_DOF_BlurKernelSize=true,bOverride_DOF_BlurBloomKernelSize=true,bOverride_DOF_MaxNearBlurAmount=true,bOverride_DOF_MinBlurAmount=false,bOverride_DOF_MaxFarBlurAmount=true,bOverride_DOF_FocusType=true,bOverride_DOF_FocusInnerRadius=true,bOverride_DOF_FocusDistance=true,bOverride_DOF_FocusPosition=true,bOverride_DOF_InterpolationDuration=true,bOverride_DOF_BokehTexture=false,bOverride_MotionBlur_MaxVelocity=false,bOverride_MotionBlur_Amount=false,bOverride_MotionBlur_FullMotionBlur=false,bOverride_MotionBlur_CameraRotationThreshold=false,bOverride_MotionBlur_CameraTranslationThreshold=false,bOverride_MotionBlur_InterpolationDuration=false,bOverride_Scene_Desaturation=true,bOverride_Scene_Colorize=false,bOverride_Scene_TonemapperScale=false,bOverride_Scene_ImageGrainScale=false,bOverride_Scene_HighLights=true,bOverride_Scene_MidTones=true,bOverride_Scene_Shadows=true,bOverride_Scene_InterpolationDuration=true,bOverride_Scene_ColorGradingLUT=false,bOverride_RimShader_Color=true,bOverride_RimShader_InterpolationDuration=true,bOverride_MobileColorGrading=false,bEnableBloom=true,bEnableDOF=false,bEnableMotionBlur=true,bEnableSceneEffect=true,bAllowAmbientOcclusion=true,bOverrideRimShaderColor=false,Bloom_Scale=1.0000000,Bloom_Threshold=1.0000000,Bloom_Tint=(R=255,G=255,B=255,A=0),Bloom_ScreenBlendThreshold=10.0000000,Bloom_InterpolationDuration=1.0000000,DOF_BlurBloomKernelSize=16.0000000,DOF_FalloffExponent=4.0000000,DOF_BlurKernelSize=16.0000000,DOF_MaxNearBlurAmount=1.0000000,DOF_MinBlurAmount=0.0000000,DOF_MaxFarBlurAmount=1.0000000,DOF_FocusType=EFocusType.FOCUS_Distance,DOF_FocusInnerRadius=2000.0000000,DOF_FocusDistance=0.0000000,DOF_FocusPosition=(X=0.0000000,Y=0.0000000,Z=0.0000000),DOF_InterpolationDuration=1.0000000,DOF_BokehTexture=none,MotionBlur_MaxVelocity=1.0000000,MotionBlur_Amount=0.5000000,MotionBlur_FullMotionBlur=true,MotionBlur_CameraRotationThreshold=45.0000000,MotionBlur_CameraTranslationThreshold=10000.0000000,MotionBlur_InterpolationDuration=1.0000000,Scene_Desaturation=0.0000000,Scene_Colorize=(X=1.0000000,Y=1.0000000,Z=1.0000000),Scene_TonemapperScale=1.0000000,Scene_ImageGrainScale=0.0000000,Scene_HighLights=(X=1.0000000,Y=1.0000000,Z=1.0000000),Scene_MidTones=(X=1.0000000,Y=1.0000000,Z=1.0000000),Scene_Shadows=(X=0.0000000,Y=0.0000000,Z=0.0000000),Scene_InterpolationDuration=1.0000000,RimShader_Color=(R=0.4704400,G=0.5859730,B=0.8277260,A=1.0000000),RimShader_InterpolationDuration=1.0000000,ColorGrading_LookupTable=none,ColorGradingLUT=(LUTTextures=none,LUTWeights=none),MobileColorGrading=(TransitionTime=1.0000000,Blend=0.0000000,Desaturation=0.0000000,HighLights=(R=0.7000000,G=0.7000000,B=0.7000000,A=1.0000000),MidTones=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000),Shadows=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)),MobilePostProcess=(bOverride_Mobile_BlurAmount=false,bOverride_Mobile_TransitionTime=false,bOverride_Mobile_Bloom_Scale=false,bOverride_Mobile_Bloom_Threshold=false,bOverride_Mobile_Bloom_Tint=false,bOverride_Mobile_DOF_Distance=false,bOverride_Mobile_DOF_MinRange=false,bOverride_Mobile_DOF_MaxRange=false,bOverride_Mobile_DOF_NearBlurFactor=false,bOverride_Mobile_DOF_FarBlurFactor=false,Mobile_BlurAmount=16.0000000,Mobile_TransitionTime=1.0000000,Mobile_Bloom_Scale=6.0000000,Mobile_Bloom_Threshold=0.5000000,Mobile_Bloom_Tint=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000),Mobile_DOF_Distance=1500.0000000,Mobile_DOF_MinRange=600.0000000,Mobile_DOF_MaxRange=1200.0000000,Mobile_DOF_NearBlurFactor=1.0000000,Mobile_DOF_FarBlurFactor=1.0000000),Death_Enable=false,Death_DesatAlpha=0.0000000,Hit_Enable=false,Hit_FadeAlpha=0.0000000,ColorBlind_Enable=false,ColorBlind_Mode=0)
    // Reference: BrushComponent'Engine.Default__PostProcessVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        CollideActors=false
        BlockNonZeroExtent=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=false
    bTickIsDisabled=true
    bCollideActors=false
    CollisionComponent=BrushComponent0
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
}