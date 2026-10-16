class SceneCapturePortalComponent extends SceneCaptureComponent
    native
    hidecategories(Object);

var(Capture) const TextureRenderTarget2D TextureTarget;
var(Capture) const float ScaleFOV;
var(Capture) const Actor ViewDestination;

// Export USceneCapturePortalComponent::execSetCaptureParameters(FFrame&, void* const)
native final function SetCaptureParameters(optional TextureRenderTarget2D NewTextureTarget = TextureTarget, optional float NewScaleFOV = ScaleFOV, optional Actor NewViewDest = ViewDestination);

defaultproperties
{
    ScaleFOV=1.0000000
    bSkipUpdateIfOwnerOccluded=true
    FrameRate=1000.0000000
}