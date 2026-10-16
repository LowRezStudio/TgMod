class ParticleModuleUberRainDrops extends ParticleModuleUberBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

var(Lifetime) float LifetimeMin;
var(Lifetime) float LifetimeMax;
var(Size) Vector StartSizeMin;
var(Size) Vector StartSizeMax;
var(Velocity) Vector StartVelocityMin;
var(Velocity) Vector StartVelocityMax;
var(Velocity) float StartVelocityRadialMin;
var(Velocity) float StartVelocityRadialMax;
var(Color) Vector ColorOverLife;
var(Color) float AlphaOverLife;
var(Location) bool bIsUsingCylinder;
var(Location) bool bPositive_X;
var(Location) bool bPositive_Y;
var(Location) bool bPositive_Z;
var(Location) bool bNegative_X;
var(Location) bool bNegative_Y;
var(Location) bool bNegative_Z;
var(Location) bool bSurfaceOnly;
var(Location) bool bVelocity;
var(Location) bool bRadialVelocity;
var(Location) float PC_VelocityScale;
var(Location) Vector PC_StartLocation;
var(Location) float PC_StartRadius;
var(Location) float PC_StartHeight;
var(Location) ParticleModuleLocationPrimitiveCylinder.CylinderHeightAxis PC_HeightAxis;
var(Location) Vector StartLocationMin;
var(Location) Vector StartLocationMax;

defaultproperties
{
    LifetimeMin=1.0000000
    LifetimeMax=1.0000000
    StartSizeMin=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    StartSizeMax=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    StartVelocityMin=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    StartVelocityMax=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    ColorOverLife=(X=255.9000000,Y=255.9000000,Z=255.9000000)
    AlphaOverLife=255.9000000
    bPositive_X=true
    bPositive_Y=true
    bPositive_Z=true
    bNegative_X=true
    bNegative_Y=true
    bNegative_Z=true
    bRadialVelocity=true
    PC_VelocityScale=1.0000000
    PC_StartRadius=50.0000000
    PC_StartHeight=50.0000000
    PC_HeightAxis=CylinderHeightAxis.PMLPC_HEIGHTAXIS_Z
    bSpawnModule=true
    bUpdateModule=true
    bSupported3DDrawMode=true
}