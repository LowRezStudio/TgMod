class TgAnimBlendByPaladinsCharacter extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EPalCharParams
{
    PCP_FireInhand,                 // 0
    PCP_FireAlt,                    // 1
    PCP_FireAbility,                // 2
    PCP_FireMovement,               // 3
    PCP_FireUlt,                    // 4
    PCP_Reload,                     // 5
    PCP_Retrieve,                   // 6
    PCP_Emote,                      // 7
    PCP_FireSupportingDevice,       // 8
    PCP_PutAway,                    // 9
    PCP_CharacterSpecific1,         // 10
    PCP_CharacterSpecific2,         // 11
    PCP_CharacterSpecific3,         // 12
    PCP_CharacterSpecific4,         // 13
    PCP_CharacterSpecific5,         // 14
    PCP_Intro,                      // 15
    PCP_Outro,                      // 16
    PCP_MAX                         // 17
};

struct native ChildAnimParameters
{
    var() const editconst string SlotName;
    var() const editconst TgObject.TG_EQUIP_POINT EquipSlot;
    var() const editconst int ChildIndex;
    var() bool bBlendInOnTargeting;
    var() bool bBlendInOnBuildup;
    var() bool bBlendInOnStartFire;
    var() bool bBlendInOnFire;
    var() bool bBlendOutIfStopped;
    var() bool bBlendOutOnAnimEnd;
    var() bool bBlendOutOnChildNotification;
    var() bool bEndCurrentAnimIfNoChild;
    var() bool bAddToStackIfOtherAnimInterrupted;
    var() bool bAddToStackOnCeaseRelevant;
    var() bool bIgnoreSwapLogicIfNotRelevant;
    var() bool bReplayIfActivatedFromStack;
    var() bool bReplayIfActive;
    var() bool bAutoScaleByDuration;
    var() float fAutoScaledPlayRateMultiplier;
    var() bool bInterruptOtherAnims;
    var() array<int> nInterruptExceptionsByChildIndex;
    var() int nCustomRetrieveIndex;

    structdefaultproperties
    {
        SlotName=""
        EquipSlot=TG_EQUIP_POINT.EQP_NONE
        ChildIndex=0
        bBlendInOnTargeting=false
        bBlendInOnBuildup=false
        bBlendInOnStartFire=true
        bBlendInOnFire=false
        bBlendOutIfStopped=false
        bBlendOutOnAnimEnd=true
        bBlendOutOnChildNotification=true
        bEndCurrentAnimIfNoChild=false
        bAddToStackIfOtherAnimInterrupted=false
        bAddToStackOnCeaseRelevant=false
        bIgnoreSwapLogicIfNotRelevant=false
        bReplayIfActivatedFromStack=false
        bReplayIfActive=true
        bAutoScaleByDuration=false
        fAutoScaledPlayRateMultiplier=1.0000000
        bInterruptOtherAnims=true
        nInterruptExceptionsByChildIndex=none
        nCustomRetrieveIndex=-1
    }
};

var TgWeaponMeshActor m_WeaponMeshActor;
var(PaladinChar) TgObject.TG_EQUIP_POINT m_SubNodeEquipSlot;
var(PaladinChar) ChildAnimParameters m_ChildParams[EPalCharParams];
var array<TgAnimBlendByPaladinsCharacter.EPalCharParams> m_nChildAnimStack;
var int m_nCustomRetrieveIndex;
var(PaladinChar) bool m_bBlendToIdleOnInterruptInspect;

// Export UTgAnimBlendByPaladinsCharacter::execOnDeviceTargeting(FFrame&, void* const)
native function OnDeviceTargeting(TgObject.TG_EQUIP_POINT eqp);

// Export UTgAnimBlendByPaladinsCharacter::execOnDeviceBuildup(FFrame&, void* const)
native function OnDeviceBuildup(TgObject.TG_EQUIP_POINT eqp);

// Export UTgAnimBlendByPaladinsCharacter::execOnDeviceStartFire(FFrame&, void* const)
native function OnDeviceStartFire(TgObject.TG_EQUIP_POINT eqp, float fRefireRate);

// Export UTgAnimBlendByPaladinsCharacter::execOnDeviceFire(FFrame&, void* const)
native function OnDeviceFire(TgObject.TG_EQUIP_POINT eqp, float fRefireRate);

// Export UTgAnimBlendByPaladinsCharacter::execOnDeviceStopFire(FFrame&, void* const)
native function OnDeviceStopFire(TgObject.TG_EQUIP_POINT eqp);

// Export UTgAnimBlendByPaladinsCharacter::execOnReload(FFrame&, void* const)
native function OnReload(float fReloadTime);

// Export UTgAnimBlendByPaladinsCharacter::execOnFlourish(FFrame&, void* const)
native function OnFlourish();

// Export UTgAnimBlendByPaladinsCharacter::execOnRetrieve(FFrame&, void* const)
native function OnRetrieve();

// Export UTgAnimBlendByPaladinsCharacter::execOnPutAway(FFrame&, void* const)
native function OnPutAway(byte EquipPoint, int DeviceID, Class<TgDevice> WeaponClass);

// Export UTgAnimBlendByPaladinsCharacter::execInterruptReload(FFrame&, void* const)
native function InterruptReload();

// Export UTgAnimBlendByPaladinsCharacter::execForceInterruptFlourish(FFrame&, void* const)
native function ForceInterruptFlourish();

// Export UTgAnimBlendByPaladinsCharacter::execPlayTopOfStackAnim(FFrame&, void* const)
native function PlayTopOfStackAnim();

// Export UTgAnimBlendByPaladinsCharacter::execUpdateAnimViaStackRemoval(FFrame&, void* const)
native function UpdateAnimViaStackRemoval(TgAnimBlendByPaladinsCharacter.EPalCharParams toRemove);

// Export UTgAnimBlendByPaladinsCharacter::execGetParamIndexFromEqpSlot(FFrame&, void* const)
native function TgAnimBlendByPaladinsCharacter.EPalCharParams GetParamIndexFromEqpSlot(TgObject.TG_EQUIP_POINT eqp);

// Export UTgAnimBlendByPaladinsCharacter::execGetParamIndexFromChildIndex(FFrame&, void* const)
native function TgAnimBlendByPaladinsCharacter.EPalCharParams GetParamIndexFromChildIndex(int Index);

// Export UTgAnimBlendByPaladinsCharacter::execSetActiveChild(FFrame&, void* const)
native function SetActiveChild(int ChildIndex, float BlendTime);

// Export UTgAnimBlendByPaladinsCharacter::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float InRate = 1.0000000, optional float StartTime = 0.0000000);

// Export UTgAnimBlendByPaladinsCharacter::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

defaultproperties
{
    m_ChildParams[0]=(SlotName="Fire Inhand",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=1,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=true,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[1]=(SlotName="Fire Alt",EquipSlot=TG_EQUIP_POINT.EQP_ALT_FIRE,ChildIndex=2,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[2]=(SlotName="Fire Ability",EquipSlot=TG_EQUIP_POINT.EQP_OFFHAND_2,ChildIndex=3,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[3]=(SlotName="Fire Movement",EquipSlot=TG_EQUIP_POINT.EQP_OFFHAND_3,ChildIndex=4,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[4]=(SlotName="Fire Ult",EquipSlot=TG_EQUIP_POINT.EQP_OFFHAND_1,ChildIndex=5,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[5]=(SlotName="Reload",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=6,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[6]=(SlotName="Retrieve",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=7,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[7]=(SlotName="Emote",EquipSlot=TG_EQUIP_POINT.EQP_EMOTE,ChildIndex=8,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[8]=(SlotName="Fire Supporting Device",EquipSlot=TG_EQUIP_POINT.EQP_SUPPORT,ChildIndex=9,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[9]=(SlotName="Put Away",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=10,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[10]=(SlotName="Unused 1",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=11,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[11]=(SlotName="Unused 2",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=12,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[12]=(SlotName="Unused 3",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=13,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[13]=(SlotName="Unused 4",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=14,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[14]=(SlotName="Unused 5",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=15,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[15]=(SlotName="Intro",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=16,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_ChildParams[16]=(SlotName="Outro",EquipSlot=TG_EQUIP_POINT.EQP_AUTO,ChildIndex=17,bBlendInOnTargeting=false,bBlendInOnBuildup=false,bBlendInOnStartFire=true,bBlendInOnFire=false,bBlendOutIfStopped=false,bBlendOutOnAnimEnd=true,bBlendOutOnChildNotification=true,bEndCurrentAnimIfNoChild=false,bAddToStackIfOtherAnimInterrupted=false,bAddToStackOnCeaseRelevant=false,bIgnoreSwapLogicIfNotRelevant=false,bReplayIfActivatedFromStack=false,bReplayIfActive=true,bAutoScaleByDuration=false,fAutoScaledPlayRateMultiplier=1.0000000,bInterruptOtherAnims=true,nInterruptExceptionsByChildIndex=none,nCustomRetrieveIndex=-1)
    m_nCustomRetrieveIndex=-1
    DefaultBlendTime=0.1500000
    bPlayActiveChild=true
    PlayActiveChildExceptionList=/* Array type was not detected. */
    Children=/* Array type was not detected. */
}