class PComPictureInPictureScene extends Object
    native;

var() float SkyBrightness;
var() Color SkyColor;
var() float LightBrightness;
var() bool bAlwaysAllowAudioPlayback;
var() bool bForceAllUsedMipsResident;
var native transient Pointer Scene;
var export editinline array<export editinline ActorComponent> Components;
var export editinline DirectionalLightComponent DirectionalLight;
var export editinline DirectionalLightComponent DirectionalBounceLight;
var export editinline SkyLightComponent SkyLight;
var export editinline LineBatchComponent LineBatcher;

// Export UPComPictureInPictureScene::execInitScene(FFrame&, void* const)
native function InitScene();

// Export UPComPictureInPictureScene::execAddComponent(FFrame&, void* const)
native function AddComponent(ActorComponent Component, const out Matrix LocalToWorld);

// Export UPComPictureInPictureScene::execRemoveComponent(FFrame&, void* const)
native function RemoveComponent(ActorComponent Component);

// Export UPComPictureInPictureScene::execGetLightDirection(FFrame&, void* const)
native function Rotator GetLightDirection();

// Export UPComPictureInPictureScene::execSetLightDirection(FFrame&, void* const)
native function SetLightDirection(const out Rotator InLightDir);

// Export UPComPictureInPictureScene::execSetLightBrightness(FFrame&, void* const)
native function SetLightBrightness(float InLightBrightness);

// Export UPComPictureInPictureScene::execSetLightColor(FFrame&, void* const)
native function SetLightColor(const out Color LightColor);

// Export UPComPictureInPictureScene::execEnableDirectionalBounceLight(FFrame&, void* const)
native function EnableDirectionalBounceLight(bool bInEnableBoundLight, optional float InBounceLightBrightness = 0.0000000, optional Rotator BounceLightDir);

// Export UPComPictureInPictureScene::execSetBounceLightDirection(FFrame&, void* const)
native function SetBounceLightDirection(const out Rotator InLightDir);

// Export UPComPictureInPictureScene::execSetBounceLightBrightness(FFrame&, void* const)
native function SetBounceLightBrightness(float InLightBrightness);

// Export UPComPictureInPictureScene::execSetBounceLightColor(FFrame&, void* const)
native function SetBounceLightColor(const out Color LightColor);

// Export UPComPictureInPictureScene::execSetSkyBrightness(FFrame&, void* const)
native function SetSkyBrightness(float InSkyBrightness);

// Export UPComPictureInPictureScene::execSetSkyColor(FFrame&, void* const)
native function SetSkyColor(const out Color InSkyColor);

defaultproperties
{
    SkyBrightness=0.2500000
    SkyColor=(R=255,G=255,B=255,A=255)
    LightBrightness=1.0000000
    bForceAllUsedMipsResident=true
}