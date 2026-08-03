class EngineBaseTypes extends Object
    abstract
    native(Base);

struct native RenderingPerformanceOverrides
{
    var() bool bAllowAmbientOcclusion;
    var() bool bAllowDominantWholeSceneDynamicShadows;
    var() bool bAllowMotionBlurSkinning;
    var() bool bAllowTemporalAA;
    var() bool bAllowLightShafts;

    structdefaultproperties
    {
        bAllowAmbientOcclusion=true
        bAllowDominantWholeSceneDynamicShadows=true
        bAllowMotionBlurSkinning=true
        bAllowTemporalAA=true
        bAllowLightShafts=true
    }
};
