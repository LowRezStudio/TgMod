class FluidInfluenceComponent extends PrimitiveComponent
    native(Fluid)
    editinlinenew
    hidecategories(Object,Collision,Lighting,Physics,PrimitiveComponent,Rendering)
    autoexpandcategories(FluidInfluenceComponent);

enum EInfluenceType
{
    Fluid_Flow,                     // 0
    Fluid_Raindrops,                // 1
    Fluid_Wave,                     // 2
    Fluid_Sphere,                   // 3
    Fluid_MAX                       // 4
};

var() bool bActive;
var(FluidRaindrops) interp bool RaindropFillEntireFluid;
var transient bool bIsToggleTriggered;
var() FluidSurfaceActor FluidActor;
var() FluidInfluenceComponent.EInfluenceType InfluenceType;
var() float MaxDistance;
var(FluidWave) interp float WaveStrength;
var(FluidWave) interp float WaveFrequency;
var(FluidWave) interp float WavePhase;
var(FluidWave) interp float WaveRadius;
var(FluidRaindrops) interp float RaindropAreaRadius;
var(FluidRaindrops) interp float RaindropRadius;
var(FluidRaindrops) interp float RaindropStrength;
var(FluidRaindrops) interp float RaindropRate;
var(FluidFlow) interp float FlowSpeed;
var(FluidFlow) interp int FlowNumRipples;
var(FluidFlow) interp float FlowSideMotionRadius;
var(FluidFlow) interp float FlowWaveRadius;
var(FluidFlow) interp float FlowStrength;
var(FluidFlow) interp float FlowFrequency;
var(FluidSphere) interp float SphereOuterRadius;
var(FluidSphere) interp float SphereInnerRadius;
var(FluidSphere) interp float SphereStrength;
var private native transient float CurrentAngle;
var private native transient float CurrentTimer;
var private native transient FluidSurfaceActor CurrentFluidActor;

defaultproperties
{
    bActive=true
    RaindropFillEntireFluid=true
    InfluenceType=EInfluenceType.Fluid_Wave
    MaxDistance=1000.0000000
    WaveStrength=40.0000000
    WaveFrequency=1.0000000
    WaveRadius=50.0000000
    RaindropAreaRadius=300.0000000
    RaindropRadius=10.0000000
    RaindropStrength=5.0000000
    RaindropRate=20.0000000
    FlowSpeed=100.0000000
    FlowNumRipples=10
    FlowSideMotionRadius=30.0000000
    FlowWaveRadius=50.0000000
    FlowStrength=20.0000000
    FlowFrequency=4.0000000
    SphereOuterRadius=100.0000000
    SphereInnerRadius=50.0000000
    SphereStrength=-40.0000000
    ReplacementPrimitive=none
    bTickInEditor=true
}