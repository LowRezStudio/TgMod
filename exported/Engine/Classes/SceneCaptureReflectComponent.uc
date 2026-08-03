class SceneCaptureReflectComponent extends SceneCaptureComponent
    native
    hidecategories(Object);

var(Capture) TextureRenderTarget2D TextureTarget;
var(Capture) float ScaleFOV;
var(Capture) array<Actor> ActorsToReflect;

defaultproperties
{
    ScaleFOV=1.0000000
    FrameRate=1000.0000000
}