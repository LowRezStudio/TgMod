class TgSkeletalMeshActor_Lobby extends TgSkeletalMeshActor_LobbyBase
    native(Pawns)
    hidecategories(Navigation,SkeletalMeshActor,TgSkeletalMeshActor,SkeletalMeshActor,TgSkeletalMeshActor)
    autoexpandcategories(TgSkeletalMeshActor_Loader,TgSkeletalMeshActor_Lobby)
    config(Engine)
    dependson(TgPawn);

enum LobbyMeterBusIntent {
    LMB_RUCKUSGEM,  // 0
};

struct LobbySMAMeterBus {
    var dword dwBusID;
    var TgSkeletalMeshActor_Lobby.LobbyMeterBusIntent eIntent;
    structdefaultproperties {}
};

var float m_fSpawnOffsetYaw;
var float m_fMaxSpawnRotation;
var float m_fMinSpawnRotation;
var () bool m_bAdjustMeshToGround;
var () bool m_bCanBeRotated;
var (Posture) bool m_bEnablePostures;
var transient int m_CardMICBotIdPending;
var transient float m_CardMICTransitionDesiredAlpha;
var transient float m_CardMICTransitionAlpha;
var () TgSkeletalMeshActor_FlagStand m_FlagStandActor;
var () TgSkeletalMeshActor_Pedestal m_PedestalActor;
var () array<MaterialInstanceConstant> m_CardMICs;
var array<MaterialInstanceConstant> m_MeshReplacementMICs;
var array<LobbySMAMeterBus> m_MeterBusses;
var (Posture) repnotify TgPawn.TG_POSTURE r_CurrentPosture;
var transient float m_fRotationAmount;
var transient float m_fDesiredRotationAmount;
var transient Rotator m_rOriginalRotation;
var transient float m_fSelectionGlowRemainingTime;
var float m_fSelectionGlowTotalTime;
var transient array<TgAnimBlendByPosture> m_PostureBlendNodes;

native function SetActive(bool bActive);  // Export UTgSkeletalMeshActor_Lobby::execSetActive(FFrame&, void* const)

native function RotateModel(float fValue, optional bool bSnap=false);  // Export UTgSkeletalMeshActor_Lobby::execRotateModel(FFrame&, void* const)

native function AdjustMeshToGround();  // Export UTgSkeletalMeshActor_Lobby::execAdjustMeshToGround(FFrame&, void* const)

native function AllManifestsLoaded();  // Export UTgSkeletalMeshActor_Lobby::execAllManifestsLoaded(FFrame&, void* const)

native function ReplaceMaterialInstances();  // Export UTgSkeletalMeshActor_Lobby::execReplaceMaterialInstances(FFrame&, void* const)

native function TeardownMeterBusses();  // Export UTgSkeletalMeshActor_Lobby::execTeardownMeterBusses(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event PreBeginPlay() { }

simulated event PostBeginPlay() { }

simulated event EndTransition() { }

simulated event Destroyed() { }

function float GetSpawnRotation() { }

event PostInitAnimTree(SkeletalMeshComponent SkelComp) { }

simulated event InitPostureNodes() { }

simulated function SetActivePosture(TgPawn.TG_POSTURE Posture) { }

simulated event OnSetSkelPosture(TgSeqAct_SetSkelPosture Action) { }

defaultproperties
{}
