class TgSpawnGate extends DynamicBlockingVolume
    native(Volumes)
    hidecategories(Navigation,Object,Display)
    config(Engine);

enum ESpawnGateType {
    SPGT_Standard,  // 0
    SPGT_Attackers,  // 1
    SPGT_Defenders,  // 2
};

var () TgSpawnGate.ESpawnGateType m_eSpawnGateType;
var () Emitter m_StandardEmitter;
var () TgEmitter_TeamColor m_TeamColoredEmitter;
var () bool m_bStartActive;
var bool m_bGateOpen;
var () int m_nCurrentTaskforce;

native function int GetCurrentTaskforce();  // Export UTgSpawnGate::execGetCurrentTaskforce(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated function Activate() { }

simulated function Deactivate() { }

simulated function ToggleTeamColors() { }

defaultproperties
{}
