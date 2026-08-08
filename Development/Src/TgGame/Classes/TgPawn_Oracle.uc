class TgPawn_Oracle extends TgPawn_Character
    native(ChampOracle)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

const ORACLE_MAX_STACKS_PER_TARGET = 4;

const ORACLE_MAX_STACK_TARGETS = 10;

const ORACLE_STACK_FX_GROUP_ID = 57644;

const ORACLE_STACK_1P_FX_ID = 7739;

const ORACLE_STACK_3P_FX_ID = 7740;

var Actor r_RestoreSoulTarget;
var Vector r_RestoreSoulHitOffset;
var bool r_bRestoreSoulActive;
var bool r_bHasAgonyTalent;
var int r_SoulStackTargetPawnId[10];
var repnotify int r_SoulStackTargetCount[10];
var int c_CachedSoulStackTargetCount[10];
var Vector c_InterpRestoreSoulHitOffset;
var float c_fRestoreSoulHitOffsetInterpSpeed;
var () float m_fFrictionMultiplier;
var int m_nStackAddedVictimFxId;
var int m_nStackAddedSourceFxId;
var int m_nMaxStacksVictimFxId;
var int m_nMaxStacksSourceFxId;

replication {
    if(bNetDirty) r_RestoreSoulHitOffset, r_RestoreSoulTarget, r_SoulStackTargetCount, r_SoulStackTargetPawnId, r_bHasAgonyTalent, r_bRestoreSoulActive;
}

simulated event ReplicatedEvent(name VarName) { }

simulated function Tick(float DeltaSeconds) { }

native function UpdateSoulStacks();  // Export UTgPawn_Oracle::execUpdateSoulStacks(FFrame&, void* const)

native function OnSoulStacksReplicated();  // Export UTgPawn_Oracle::execOnSoulStacksReplicated(FFrame&, void* const)

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
