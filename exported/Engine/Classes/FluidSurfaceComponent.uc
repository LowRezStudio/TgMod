class FluidSurfaceComponent extends PrimitiveComponent
    native(Fluid)
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(FluidSurfaceComponent,Fluid,FluidDetail);

var() MaterialInterface FluidMaterial;
var(Lighting) int LightMapResolution;
var(Lightmass) LightmassPrimitiveSettings LightmassSettings;
var(Fluid) bool EnableSimulation;
var(Fluid) bool EnableDetail;
var(FluidDetail) bool bTiling;
var(FluidDebug) transient bool bPause;
var(FluidDebug) transient bool bShowSimulationNormals;
var(FluidDebug) bool bShowSimulationPosition;
var(FluidDebug) bool bShowDetailNormals;
var(FluidDebug) bool bShowDetailPosition;
var(FluidDebug) transient bool bShowFluidSimulation;
var(FluidDebug) transient bool bShowFluidDetail;
var(FluidDebug) bool bTestRipple;
var(FluidDebug) bool bTestRippleCenterOnDetail;
var(Fluid) int SimulationQuadsX;
var(Fluid) int SimulationQuadsY;
var(Fluid) float GridSpacing;
var(Fluid) float GridSpacingLowRes;
var(Fluid) Actor TargetSimulation;
var(Fluid) float GPUTessellationFactor;
var(Fluid) float FluidDamping;
var(Fluid) float FluidTravelSpeed;
var(Fluid) float FluidHeightScale;
var(Fluid) float FluidUpdateRate;
var(Fluid) float ForceImpact;
var(Fluid) float ForceContinuous;
var(Fluid) float LightingContrast;
var(Fluid) Actor TargetDetail;
var(Fluid) float DeactivationDistance;
var(FluidDetail) int DetailResolution;
var(FluidDetail) float DetailSize;
var(FluidDetail) float DetailDamping;
var(FluidDetail) float DetailTravelSpeed;
var(FluidDetail) float DetailTransfer;
var(FluidDetail) float DetailHeightScale;
var(FluidDetail) float DetailUpdateRate;
var(FluidDebug) float NormalLength;
var(FluidDebug) float TestRippleSpeed;
var(FluidDebug) float TestRippleFrequency;
var(FluidDebug) float TestRippleRadius;
var private float FluidWidth;
var private float FluidHeight;
var private native transient float TestRippleTime;
var private native transient float TestRippleAngle;
var private native transient float DeactivationTimer;
var private native transient float ViewDistance;
var private native transient Vector SimulationPosition;
var private native transient Vector DetailPosition;
var const array<byte> ClampMap;
var private const array<ShadowMap2D> ShadowMaps;
var private native const LightMapRef LightMap;
var private native const transient Pointer FluidSimulation;

// Export UFluidSurfaceComponent::execApplyForce(FFrame&, void* const)
native final function ApplyForce(Vector WorldPos, float Strength, float Radius, optional bool bImpulse);

// Export UFluidSurfaceComponent::execSetDetailPosition(FFrame&, void* const)
native final function SetDetailPosition(Vector WorldPos);

// Export UFluidSurfaceComponent::execSetSimulationPosition(FFrame&, void* const)
native final function SetSimulationPosition(Vector WorldPos);

defaultproperties
{
    LightMapResolution=128
    LightmassSettings=(bUseTwoSidedLighting=false,bShadowIndirectOnly=false,bUseEmissiveForStaticLighting=false,EmissiveLightFalloffExponent=2.0000000,EmissiveLightExplicitInfluenceRadius=0.0000000,EmissiveBoost=1.0000000,DiffuseBoost=1.0000000,SpecularBoost=1.0000000,FullyOccludedSamplesFraction=1.0000000)
    EnableSimulation=true
    EnableDetail=true
    bShowFluidSimulation=true
    bShowFluidDetail=true
    SimulationQuadsX=200
    SimulationQuadsY=200
    GridSpacing=10.0000000
    GridSpacingLowRes=800.0000000
    GPUTessellationFactor=1.0000000
    FluidDamping=1.0000000
    FluidTravelSpeed=1.0000000
    FluidHeightScale=1.0000000
    FluidUpdateRate=30.0000000
    ForceImpact=-3.0000000
    ForceContinuous=-200.0000000
    LightingContrast=1.0000000
    DeactivationDistance=3000.0000000
    DetailResolution=256
    DetailSize=500.0000000
    DetailDamping=1.0000000
    DetailTravelSpeed=1.0000000
    DetailTransfer=0.5000000
    DetailHeightScale=1.0000000
    DetailUpdateRate=30.0000000
    NormalLength=10.0000000
    TestRippleSpeed=1.0000000
    TestRippleFrequency=1.0000000
    TestRippleRadius=30.0000000
    FluidWidth=2000.0000000
    FluidHeight=2000.0000000
    ReplacementPrimitive=none
    bIgnoreNearPlaneIntersection=true
    bForceDirectLightMap=true
    bAcceptsLights=true
    bUsePrecomputedShadows=true
    CollideActors=true
    BlockZeroExtent=true
    BlockNonZeroExtent=true
    bTickInEditor=true
}