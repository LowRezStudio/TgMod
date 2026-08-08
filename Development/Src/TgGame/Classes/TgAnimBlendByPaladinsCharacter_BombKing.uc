class TgAnimBlendByPaladinsCharacter_BombKing extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgObject);

native function OnDeviceStartFire(TgObject.TG_EQUIP_POINT eqp, float fRefireRate);  // Export UTgAnimBlendByPaladinsCharacter_BombKing::execOnDeviceStartFire(FFrame&, void* const)

defaultproperties
{
    m_ChildParams[10]=(SlotName="Ability Retrieve")
    Children=/* Array type was not detected. */
}
