class SceneCaptureCubeMapComponent extends SceneCaptureComponent
    native
    hidecategories(Object);

var(Capture) TextureRenderTargetCube TextureTarget;
var(Capture) float NearPlane;
var(Capture) float FarPlane;
var private native const transient Vector WorldLocation;

defaultproperties
{
    NearPlane=20.0000000
    FarPlane=500.0000000
}