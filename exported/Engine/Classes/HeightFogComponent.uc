class HeightFogComponent extends ActorComponent
    native
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() const bool bEnabled;
var const float Height;
var() interp const float Density;
var() interp const float LightBrightness;
var() interp const Color LightColor;
var() interp const float ExtinctionDistance;
var() interp const float StartDistance;

// Export UHeightFogComponent::execSetEnabled(FFrame&, void* const)
native final function SetEnabled(bool bSetEnabled);

defaultproperties
{
    bEnabled=true
    Density=0.0000500
    LightBrightness=0.1000000
    LightColor=(R=255,G=255,B=255,A=0)
    ExtinctionDistance=100000000.0000000
}