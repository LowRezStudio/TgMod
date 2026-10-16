class FogVolumeDensityComponent extends ActorComponent
    abstract
    native(FogVolume)
    editinlinenew
    hidecategories(Object);

var() MaterialInterface FogMaterial;
var MaterialInterface DefaultFogVolumeMaterial;
var() const bool bEnabled;
var() bool bAffectsTranslucency;
var() bool bOnlyAffectsTranslucency;
var() bool bUseViewOriginOverride;
var() interp LinearColor SimpleLightColor;
var() interp LinearColor ApproxFogLightColor;
var() interp float StartDistance;
var() float MaxDistance;
var() array<Actor> FogVolumeActors;
var() Vector ViewOriginOverride;

// Export UFogVolumeDensityComponent::execSetEnabled(FFrame&, void* const)
native final function SetEnabled(bool bSetEnabled);

// Export UFogVolumeDensityComponent::execSetViewOriginOverride(FFrame&, void* const)
native final function SetViewOriginOverride(Vector InViewOriginOverride, bool bInUsePositionOverride);

defaultproperties
{
    DefaultFogVolumeMaterial=Material'EngineMaterials.FogVolumeMaterial'
    bEnabled=true
    bAffectsTranslucency=true
    SimpleLightColor=(R=0.5000000,G=0.5000000,B=0.7000000,A=1.0000000)
    ApproxFogLightColor=(R=0.5000000,G=0.5000000,B=0.7000000,A=1.0000000)
    MaxDistance=65535.0000000
}