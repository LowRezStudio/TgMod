class TgAnimBlendByPaladinsCharacter_Owl extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgObject);

native function TgAnimBlendByPaladinsCharacter.EPalCharParams GetParamIndexFromEqpSlot(TgObject.TG_EQUIP_POINT eqp);  // Export UTgAnimBlendByPaladinsCharacter_Owl::execGetParamIndexFromEqpSlot(FFrame&, void* const)

defaultproperties
{
    m_ChildParams[10]=(SlotName="Fire Flare",EquipSlot=EQP_SUPPORT_2)
    Children=/* Array type was not detected. */
}
