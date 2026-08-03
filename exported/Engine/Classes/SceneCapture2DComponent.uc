class SceneCapture2DComponent extends SceneCaptureComponent
    native
    hidecategories(Object);

var(Capture) const TextureRenderTarget2D TextureTarget;
var(Capture) const float FieldOfView;
var(Capture) const float NearPlane;
var(Capture) const float FarPlane;
var bool bUpdateMatrices;
var const transient Matrix ViewMatrix;
var const transient Matrix ProjMatrix;
var const transient Matrix ViewMatrix_RT;
var const transient Matrix ProjMatrix_RT;

// Export USceneCapture2DComponent::execSetCaptureParameters(FFrame&, void* const)
native final function SetCaptureParameters(optional TextureRenderTarget2D NewTextureTarget = TextureTarget, optional float NewFOV = FieldOfView, optional float NewNearPlane = NearPlane, optional float NewFarPlane = FarPlane);

// Export USceneCapture2DComponent::execSetView(FFrame&, void* const)
native final function SetView(Vector NewLocation, Rotator NewRotation);

defaultproperties
{
    FieldOfView=80.0000000
    NearPlane=20.0000000
    FarPlane=500.0000000
    bUpdateMatrices=true
    ViewMatrix=(XPlane=(W=0.0000000,X=1.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=1.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000),WPlane=(W=1.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
    ProjMatrix=(XPlane=(W=0.0000000,X=1.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=1.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000),WPlane=(W=1.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
    ViewMatrix_RT=(XPlane=(W=0.0000000,X=1.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=1.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000),WPlane=(W=1.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
    ProjMatrix_RT=(XPlane=(W=0.0000000,X=1.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=1.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000),WPlane=(W=1.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
}