class ApexStaticDestructibleComponent extends ApexStaticComponent
    native(Mesh)
    editinlinenew
    hidecategories(Object);

var(Physics) float SleepEnergyThreshold;
var(Physics) float SleepDamping;
var duplicatetransient native Pointer ApexDestructibleActor;
var duplicatetransient native Pointer ApexDestructiblePreview;
var native bool bIsThumbnailComponent;

defaultproperties
{
    SleepEnergyThreshold=1250.0000000
    SleepDamping=0.2000000
    ReplacementPrimitive=none
    bUsePrecomputedShadows=false
}