class PComPictureInPicture extends Object
    native;

const PICTURE_IN_PICTURE_BASE_WIDTH = 1920.0f;
const PICTURE_IN_PICTURE_BASE_HEIGHT = 1080.0f;

struct native PComPipViewDesc
{
    var name ViewName;
    var Vector ViewLocation;
    var Rotator ViewRotation;
    var Box Viewport;
    var PostProcessChain PostProcessChain;
    var PostProcessSettings PostProcessSettings;
    var float FOV;
    var Color ClearColor;
    var bool bDebugRenderTranslucent;
    var bool bAlwaysRender;
    var Double RequestRenderTime;
    var Double LastRenderedTime;
    var int NumFramesSinceRender;

    structdefaultproperties
    {
        ViewName="None"
        ViewLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ViewRotation=(Pitch=0,Yaw=0,Roll=0)
        Viewport=(Min=(X=0.0000000,Y=0.0000000,Z=0.0000000),Max=(X=0.0000000,Y=0.0000000,Z=0.0000000),IsValid=0)
        PostProcessChain=none
        PostProcessSettings=()//(bOverride_EnableBloom=true,bOverride_EnableDOF=true,bOverride_EnableMotionBlur=true,bOverride_EnableSceneEffect=true,bOverride_AllowAmbientOcclusion=true,bOverride_OverrideRimShaderColor=true,bOverride_Bloom_Scale=true,bOverride_Bloom_Threshold=true,bOverride_Bloom_Tint=true,bOverride_Bloom_ScreenBlendThreshold=true,bOverride_Bloom_InterpolationDuration=true,bOverride_DOF_FalloffExponent=true,bOverride_DOF_BlurKernelSize=true,bOverride_DOF_BlurBloomKernelSize=true,bOverride_DOF_MaxNearBlurAmount=true,bOverride_DOF_MinBlurAmount=false,bOverride_DOF_MaxFarBlurAmount=true,bOverride_DOF_FocusType=true,bOverride_DOF_FocusInnerRadius=true,bOverride_DOF_FocusDistance=true,bOverride_DOF_FocusPosition=true,bOverride_DOF_InterpolationDuration=true,bOverride_DOF_BokehTexture=false,bOverride_MotionBlur_MaxVelocity=false,bOverride_MotionBlur_Amount=false,bOverride_MotionBlur_FullMotionBlur=false,bOverride_MotionBlur_CameraRotationThreshold=false,bOverride_MotionBlur_CameraTranslationThreshold=false,bOverride_MotionBlur_InterpolationDuration=false,bOverride_Scene_Desaturation=true,bOverride_Scene_Colorize=false,bOverride_Scene_TonemapperScale=false,bOverride_Scene_ImageGrainScale=false,bOverride_Scene_HighLights=true,bOverride_Scene_MidTones=true,bOverride_Scene_Shadows=true,bOverride_Scene_InterpolationDuration=true,bOverride_Scene_ColorGradingLUT=false,bOverride_RimShader_Color=true,bOverride_RimShader_InterpolationDuration=true,bOverride_MobileColorGrading=false,bEnableBloom=true,bEnableDOF=false,bEnableMotionBlur=true,bEnableSceneEffect=true,bAllowAmbientOcclusion=true,bOverrideRimShaderColor=false,Bloom_Scale=1.0000000,Bloom_Threshold=1.0000000,Bloom_Tint=(R=255,G=255,B=255,A=0),Bloom_ScreenBlendThreshold=10.0000000,Bloom_InterpolationDuration=1.0000000,DOF_BlurBloomKernelSize=16.0000000,DOF_FalloffExponent=4.0000000,DOF_BlurKernelSize=16.0000000,DOF_MaxNearBlurAmount=1.0000000,DOF_MinBlurAmount=0.0000000,DOF_MaxFarBlurAmount=1.0000000,DOF_FocusType=FOCUS_Distance,DOF_FocusInnerRadius=2000.0000000,DOF_FocusDistance=0.0000000,DOF_FocusPosition=(X=0.0000000,Y=0.0000000,Z=0.0000000),DOF_InterpolationDuration=1.0000000,DOF_BokehTexture=none,MotionBlur_MaxVelocity=1.0000000,MotionBlur_Amount=0.5000000,MotionBlur_FullMotionBlur=true,MotionBlur_CameraRotationThreshold=45.0000000,MotionBlur_CameraTranslationThreshold=10000.0000000,MotionBlur_InterpolationDuration=1.0000000,Scene_Desaturation=0.0000000,Scene_Colorize=(X=1.0000000,Y=1.0000000,Z=1.0000000),Scene_TonemapperScale=1.0000000,Scene_ImageGrainScale=0.0000000,Scene_HighLights=(X=1.0000000,Y=1.0000000,Z=1.0000000),Scene_MidTones=(X=1.0000000,Y=1.0000000,Z=1.0000000),Scene_Shadows=(X=0.0000000,Y=0.0000000,Z=0.0000000),Scene_InterpolationDuration=1.0000000,RimShader_Color=(R=0.4704400,G=0.5859730,B=0.8277260,A=1.0000000),RimShader_InterpolationDuration=1.0000000,ColorGrading_LookupTable=none,ColorGradingLUT=(LUTTextures=(),LUTWeights=()),MobileColorGrading=(TransitionTime=1.0000000,Blend=0.0000000,Desaturation=0.0000000,HighLights=(R=0.7000000,G=0.7000000,B=0.7000000,A=1.0000000),MidTones=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000),Shadows=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)),MobilePostProcess=(bOverride_Mobile_BlurAmount=false,bOverride_Mobile_TransitionTime=false,bOverride_Mobile_Bloom_Scale=false,bOverride_Mobile_Bloom_Threshold=false,bOverride_Mobile_Bloom_Tint=false,bOverride_Mobile_DOF_Distance=false,bOverride_Mobile_DOF_MinRange=false,bOverride_Mobile_DOF_MaxRange=false,bOverride_Mobile_DOF_NearBlurFactor=false,bOverride_Mobile_DOF_FarBlurFactor=false,Mobile_BlurAmount=16.0000000,Mobile_TransitionTime=1.0000000,Mobile_Bloom_Scale=6.0000000,Mobile_Bloom_Threshold=0.5000000,Mobile_Bloom_Tint=(R=1.0000000,G=1.0000000,B=1.0000000,A=1.0000000),Mobile_DOF_Distance=1500.0000000,Mobile_DOF_MinRange=600.0000000,Mobile_DOF_MaxRange=1200.0000000,Mobile_DOF_NearBlurFactor=1.0000000,Mobile_DOF_FarBlurFactor=1.0000000),Death_Enable=false,Death_DesatAlpha=0.0000000,Hit_Enable=false,Hit_FadeAlpha=0.0000000,ColorBlind_Enable=false,ColorBlind_Mode=0,ColorBlind_Intensity=1.0000000)
        FOV=90.0000000
        ClearColor=(R=0,G=0,B=0,A=0)
        bDebugRenderTranslucent=false
        bAlwaysRender=false
        RequestRenderTime=()
        LastRenderedTime=()
        NumFramesSinceRender=0
    }
};

var private native const noexport Pointer VfTable_FCallbackEventDevice;
var PComPictureInPictureScene Scene;
var TextureRenderTarget2D RenderTargetToUse;
var init native array<init PComPipViewDesc> ViewDescs;
var bool bEnableDebugRendering;
var Vector2D CurrentOffset;
var Vector2D CurrentScaling;

// Export UPComPictureInPicture::execInitializeRenderTarget(FFrame&, void* const)
native final function InitializeRenderTarget();

// Export UPComPictureInPicture::execAddView(FFrame&, void* const)
native final function AddView(const out PComPipViewDesc InViewDesc);

// Export UPComPictureInPicture::execRemoveView(FFrame&, void* const)
native final function RemoveView(name ViewName);

// Export UPComPictureInPicture::execRequestRender(FFrame&, void* const)
native final function RequestRender(name ViewName);

// Export UPComPictureInPicture::execIsViewReady(FFrame&, void* const)
native final function bool IsViewReady(name ViewName);

// Export UPComPictureInPicture::execIsViewDescReady(FFrame&, void* const)
native final function bool IsViewDescReady(const out PComPipViewDesc ViewDesc);

// Export UPComPictureInPicture::execDebugRender(FFrame&, void* const)
native final function DebugRender(Canvas Canvas);

function TestPictureInPicture()
{
    //return;    
}
