class TgDevice_ArcingBeam extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

struct ArcingInfo {
    var float ArcTime;
    var float RemainingArcTime;
    var int JumpsRemaining;
    var Actor PreviousArcTarget;
    var init array<init Actor> PreviousTargets;
    var TgDeviceFire ArcFiremode;
    structdefaultproperties {}
};

struct PotentialTargetInfo {
    var Actor Target;
    var int NumHits;
    var float Dist;
    structdefaultproperties {}
};

var array<ArcingInfo> m_ArcingList;
var int m_nMaxNumArcsPerTarget;
var bool m_bCanTargetShields;
var bool m_bIsArcing;

native function Actor DetermineNextTarget(int Index);  // Export UTgDevice_ArcingBeam::execDetermineNextTarget(FFrame&, void* const)

native function bool IsValidArcTarget(Actor TestActor, ArcingInfo Info);  // Export UTgDevice_ArcingBeam::execIsValidArcTarget(FFrame&, void* const)

function TriggerArcsInArcingList(float DeltaTime) { }

simulated function Tick(float DeltaTime) { }

function int GetNumArcJumps(Actor InitialTarget, TgDeviceFire FireMode) { }

event BeginArcing(Actor InitialTarget, TgDeviceFire FireMode) { }

function EndArcing(int Index) { }

function TriggerArc(int Index) { }

defaultproperties
{
    m_nMaxNumArcsPerTarget=4
    m_bProcAsIfHandDevice=true
}
