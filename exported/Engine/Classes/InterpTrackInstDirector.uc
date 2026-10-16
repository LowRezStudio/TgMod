class InterpTrackInstDirector extends InterpTrackInst
    native(Interpolation);

var Actor OldViewTarget;
var RenderingPerformanceOverrides OldRenderingOverrides;

defaultproperties
{
    OldRenderingOverrides=(bAllowAmbientOcclusion=true,bAllowDominantWholeSceneDynamicShadows=true,bAllowMotionBlurSkinning=true,bAllowTemporalAA=true,bAllowLightShafts=true)
}