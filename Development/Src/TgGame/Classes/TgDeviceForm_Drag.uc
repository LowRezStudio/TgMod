class TgDeviceForm_Drag extends TgDeviceForm
    native(ChampMakoa)
    config(Engine)
    dependson(TgObject);

enum EDragState {
    DRAG_Inactive,  // 0
    DRAG_Throw,  // 1
    DRAG_Hit,  // 2
    DRAG_Pull,  // 3
    DRAG_EndPull,  // 4
    DRAG_MissThrow,  // 5
    DRAG_MissInvalid,  // 6
    DRAG_MissThrowEnd,  // 7
    DRAG_MissInvalidEnd,  // 8
    DRAG_CloseRangeEnd,  // 9
};

var Actor m_BeamTarget;
var bool m_bIsPawnTarget;
var int m_nPostureID;
var Vector m_vReleaseLocation;
var float m_fReleaseTime;
var const float m_fMissNoHitEndDistance;
var const float m_fMissNoHitEndTime;
var const float m_fMissInvalidEndDistance;
var const float m_fMissInvalidEndTime;
var const float m_fCloseRangeEndDistance;
var float m_fTruePostfireTime;
var export editinline TgSkeletalMeshComponent m_ChainMesh;
var const int m_nChainMeshID;
var TgSkelCon_HookChain c_ChainSkelCon;
var const name m_ChainSocket;
var array<TgAnimNodeBlendByAbilityDrag> m_DragBlendList1P;
var array<TgAnimNodeBlendByAbilityDrag> m_DragBlendList3P;
var array<TgAnimNodeBlendByAbilityDragChain> m_ChainBlendList;
var TgDeviceForm_Drag.EDragState m_DragState;

native function HandleMissConditions();  // Export UTgDeviceForm_Drag::execHandleMissConditions(FFrame&, void* const)

native function UpdateChainEffects(Vector vEndPoint);  // Export UTgDeviceForm_Drag::execUpdateChainEffects(FFrame&, void* const)

native function Vector GetChainSocketLocation();  // Export UTgDeviceForm_Drag::execGetChainSocketLocation(FFrame&, void* const)

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function CacheChainAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function ConnectBeamToTarget(Actor Target) { }

event Generic1(optional byte byExtraData) { }

event Generic2(optional byte byExtraData) { }

event Generic3(optional byte byExtraData) { }

event Generic4(optional byte byExtraData) { }

simulated event StartMissNoHitEnd() { }

simulated event StartMissInvalidEnd() { }

simulated function HideChain() { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }

event StopFire(int nFireModeNum) { }

simulated function PlayChainEffects() { }

simulated function StopChainEffects() { }

simulated event SetChainLocation(Vector vLocalChainLocation, Vector vLocalSocketLocation) { }

defaultproperties
{
    m_fMissNoHitEndDistance=80.0000000
    m_fMissNoHitEndTime=0.1000000
    m_fMissInvalidEndDistance=80.0000000
    m_fMissInvalidEndTime=0.1000000
    m_fCloseRangeEndDistance=200.0000000
    m_fTruePostfireTime=0.3000000
    m_nChainMeshID=5925
    m_ChainSocket="WSO_FX_01"
}
