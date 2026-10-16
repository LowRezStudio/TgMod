class ParticleLightEnvironmentComponent extends DynamicLightEnvironmentComponent
    native(Light);

var protected const transient int ReferenceCount;
var const transient int NumPooledReuses;
var const transient Actor SharedInstigator;
var const transient ParticleSystem SharedParticleSystem;
var bool bAllowDLESharing;

defaultproperties
{
    ReferenceCount=1
    NumPooledReuses=1
    bAllowDLESharing=true
    InvisibleUpdateTime=10.0000000
    MinTimeBetweenFullUpdates=3.0000000
    bForceCompositeAllLights=true
    bAffectedBySmallDynamicLights=false
    BoundsMethod=EDynamicLightEnvironmentBoundsMethod.DLEB_ActiveComponents
}