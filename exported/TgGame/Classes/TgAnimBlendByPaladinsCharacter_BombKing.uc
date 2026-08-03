class TgAnimBlendByPaladinsCharacter_BombKing extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object);

// Export UTgAnimBlendByPaladinsCharacter_BombKing::execOnDeviceStartFire(FFrame&, void* const)
native function OnDeviceStartFire(TgObject.TG_EQUIP_POINT eqp, float fRefireRate);

defaultproperties
{
    m_ChildParams[10]=(SlotName="Ability Retrieve")
    Children=/* Array type was not detected. */
}