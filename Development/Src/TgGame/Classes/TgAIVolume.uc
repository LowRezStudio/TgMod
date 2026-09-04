class TgAIVolume extends Volume
    native
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () int LaneIndex;
var () int TaskforceIndex;
var () bool bEnabled;

native function Vector GetRandomPointInAIVolume(optional float CollisionRadius=0.0000000);  // Export UTgAIVolume::execGetRandomPointInAIVolume(FFrame&, void* const)

simulated function OnToggle(SeqAct_Toggle Action) { }

event PostBeginPlay() { }

defaultproperties
{}
