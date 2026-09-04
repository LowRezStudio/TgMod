class TgAnimBlendByPaladinsCharacter_Owl extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object);

// Export UTgAnimBlendByPaladinsCharacter_Owl::execGetParamIndexFromEqpSlot(FFrame&, void* const)
native function TgAnimBlendByPaladinsCharacter.EPalCharParams GetParamIndexFromEqpSlot(TgObject.TG_EQUIP_POINT eqp);

defaultproperties
{
    m_ChildParams[10]=(SlotName="Fire Flare",EquipSlot=TG_EQUIP_POINT.EQP_SUPPORT_2)
    Children=/* Array type was not detected. */
}