class AnimNotify_Trails extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

struct native TrailSocketSamplePoint
{
    var Vector Position;
    var Vector Velocity;

    structdefaultproperties
    {
        Position=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct native TrailSamplePoint
{
    var float RelativeTime;
    var TrailSocketSamplePoint FirstEdgeSample;
    var TrailSocketSamplePoint ControlPointSample;
    var TrailSocketSamplePoint SecondEdgeSample;

    structdefaultproperties
    {
        RelativeTime=0.0000000
        FirstEdgeSample=(Position=(X=0.0000000,Y=0.0000000,Z=0.0000000),Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000))
        ControlPointSample=(Position=(X=0.0000000,Y=0.0000000,Z=0.0000000),Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000))
        SecondEdgeSample=(Position=(X=0.0000000,Y=0.0000000,Z=0.0000000),Velocity=(X=0.0000000,Y=0.0000000,Z=0.0000000))
    }
};

struct native TrailSample
{
    var float RelativeTime;
    var Vector FirstEdgeSample;
    var Vector ControlPointSample;
    var Vector SecondEdgeSample;

    structdefaultproperties
    {
        RelativeTime=0.0000000
        FirstEdgeSample=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ControlPointSample=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        SecondEdgeSample=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

var(Trails) ParticleSystem PSTemplate;
var(Trails) bool bIsExtremeContent;
var() editoronly bool bPreview;
var() editoronly bool bPreviewForceExplicit;
var() bool bSkipIfOwnerIsHidden;
var bool bResampleRequired;
var(Trails) name FirstEdgeSocketName;
var(Trails) name ControlPointSocketName;
var(Trails) name SecondEdgeSocketName;
var float LastStartTime;
var float EndTime;
var deprecated float SampleTimeStep;
var deprecated array<deprecated TrailSamplePoint> TrailSampleData;
var(Trails) float SamplesPerSecond;
var array<TrailSample> TrailSampledData;
var transient float CurrentTime;
var transient float TimeStep;
var transient AnimNodeSequence AnimNodeSeq;

// Export UAnimNotify_Trails::execGetNumSteps(FFrame&, void* const)
native function int GetNumSteps(int InLastTrailIndex);

defaultproperties
{
    bSkipIfOwnerIsHidden=true
    FirstEdgeSocketName="EndControl"
    ControlPointSocketName="MidControl"
    SecondEdgeSocketName="StartControl"
    SamplesPerSecond=60.0000000
    ShouldDeferIssue=true
}