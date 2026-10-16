class TgAnimBlendByPaladinsCharacter_Darklord extends TgAnimBlendByPaladinsCharacter
    native(ChampDarklord)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var TgPawn_Darklord m_CachedDarklordPawn;
var bool m_bTriggerUltKilledTargetRetrieve;
var const float m_fCounterAnimDelay;
var float m_fCounterAnimTimeStamp;
var int m_nCounterAnimIndex;

native function PlayCounterAttackAnim(bool bPlayCounterToIdleAnim);  // Export UTgAnimBlendByPaladinsCharacter_Darklord::execPlayCounterAttackAnim(FFrame&, void* const)

native function OnRetrieve();  // Export UTgAnimBlendByPaladinsCharacter_Darklord::execOnRetrieve(FFrame&, void* const)

defaultproperties
{
    m_fCounterAnimDelay=0.6000000
    m_ChildParams[10]=(SlotName="Counter To Counter Idle 1",EquipSlot=EQP_SUPPORT)
    m_ChildParams[11]=(SlotName="Counter To Counter Idle 2",EquipSlot=EQP_SUPPORT)
    m_ChildParams[12]=(SlotName="Counter To Counter Idle 3",EquipSlot=EQP_SUPPORT)
    m_ChildParams[13]=(SlotName="Ult Final Hit Retrieve")
    Children=/* Array type was not detected. */
}
