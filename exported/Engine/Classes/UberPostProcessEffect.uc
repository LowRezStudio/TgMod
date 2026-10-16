class UberPostProcessEffect extends DOFBloomMotionBlurEffect
    native
    hidecategories(Object);

enum ETonemapperType
{
    Tonemapper_Off,                 // 0
    Tonemapper_Filmic,              // 1
    Tonemapper_Customizable,        // 2
    Tonemapper_MAX                  // 3
};

enum EPostProcessAAType
{
    PostProcessAA_Off,              // 0
    PostProcessAA_FXAA0,            // 1
    PostProcessAA_FXAA1,            // 2
    PostProcessAA_FXAA2,            // 3
    PostProcessAA_FXAA3,            // 4
    PostProcessAA_FXAA4,            // 5
    PostProcessAA_FXAA5,            // 6
    PostProcessAA_MLAA,             // 7
    PostProcessAA_MAX               // 8
};

var(Scene) Vector SceneShadows;
var(Scene) Vector SceneHighLights;
var(Scene) Vector SceneMidTones;
var(Scene) float SceneDesaturation;
var(Scene) Vector SceneColorize;
var(Tonemapper) UberPostProcessEffect.ETonemapperType TonemapperType;
var(PostprocessAntiAliasing) UberPostProcessEffect.EPostProcessAAType PostProcessAAType;
var(Tonemapper) float TonemapperRange;
var(Tonemapper) float TonemapperToeFactor;
var(Tonemapper) float TonemapperScale;
var(MotionBlur) float MotionBlurSoftEdgeKernelSize;
var(Scene) bool bEnableImageGrain;
var(PostProcessEffect) bool bScaleEffectsWithViewSize;
var deprecated bool bEnableHDRTonemapper;
var(Scene) float SceneImageGrainScale;
var(Bloom,Shape) float BloomWeightSmall;
var(Bloom,Shape) float BloomWeightMedium;
var(Bloom,Shape) float BloomWeightLarge;
var(Bloom,Shape) float BloomSizeScaleSmall;
var(Bloom,Shape) float BloomSizeScaleMedium;
var(Bloom,Shape) float BloomSizeScaleLarge;
var(PostprocessAntiAliasing) float EdgeDetectionThreshold;
var native const transient LUTBlender PreviousLUTBlender;
var deprecated float SceneHDRTonemapperScale;

defaultproperties
{
    SceneShadows=(X=0.0000000,Y=0.0000000,Z=-0.0030000)
    SceneHighLights=(X=0.8000000,Y=0.8000000,Z=0.8000000)
    SceneMidTones=(X=1.3000000,Y=1.3000000,Z=1.3000000)
    SceneDesaturation=0.4000000
    SceneColorize=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    TonemapperRange=8.0000000
    TonemapperToeFactor=1.0000000
    TonemapperScale=1.0000000
    SceneImageGrainScale=0.0200000
    BloomWeightMedium=1.0000000
    BloomSizeScaleSmall=0.2500000
    BloomSizeScaleMedium=1.0000000
    BloomSizeScaleLarge=3.0000000
    EdgeDetectionThreshold=12.0000000
}