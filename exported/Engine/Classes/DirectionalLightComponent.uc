class DirectionalLightComponent extends LightComponent
    native(Light)
    editinlinenew
    hidecategories(Object);

var(AdvancedLighting) float TraceDistance;
var(CascadedShadowMaps) interp float WholeSceneDynamicShadowRadius;
var(CascadedShadowMaps) const int NumWholeSceneDynamicShadowCascades;
var(CascadedShadowMaps) const float CascadeDistributionExponent;
var(Lightmass) LightmassDirectionalLightSettings LightmassSettings;

function OnUpdatePropertyLightColor()
{
    UpdateColorAndBrightness();
    //return;    
}

function OnUpdatePropertyBrightness()
{
    UpdateColorAndBrightness();
    //return;    
}

defaultproperties
{
    TraceDistance=100000.0000000
    NumWholeSceneDynamicShadowCascades=1
    CascadeDistributionExponent=4.0000000
    LightmassSettings=(LightSourceAngle=3.0000000,IndirectLightingScale=1.0000000,IndirectLightingSaturation=1.0000000,ShadowExponent=2.0000000)
}