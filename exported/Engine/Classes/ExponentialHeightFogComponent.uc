class ExponentialHeightFogComponent extends ActorComponent
    native(FogVolume)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() const bool bEnabled;
var() interp const bool bUseActorDirectionForLightDirection;
var const float FogHeight;
var() interp float FogDensity;
var() interp const float FogHeightFalloff;
var() interp const float FogMaxOpacity;
var() interp float StartDistance;
var() interp const float LightTerminatorAngle;
var() interp const float OppositeLightBrightness;
var() interp Color OppositeLightColor;
var() interp const float LightInscatteringBrightness;
var() interp const Color LightInscatteringColor;
var Vector DominantDirectionalLightDirection;

// Export UExponentialHeightFogComponent::execSetEnabled(FFrame&, void* const)
native final function SetEnabled(bool bSetEnabled);

defaultproperties
{
    bEnabled=true
    FogDensity=0.0200000
    FogHeightFalloff=0.2000000
    FogMaxOpacity=1.0000000
    LightTerminatorAngle=45.0000000
    OppositeLightBrightness=0.2000000
    OppositeLightColor=(R=177,G=208,B=255,A=0)
    LightInscatteringBrightness=1.0000000
    LightInscatteringColor=(R=245,G=212,B=41,A=0)
    DominantDirectionalLightDirection=(X=0.0000000,Y=0.0000000,Z=1.0000000)
}