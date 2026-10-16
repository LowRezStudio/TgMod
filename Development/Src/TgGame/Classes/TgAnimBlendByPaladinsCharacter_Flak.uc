class TgAnimBlendByPaladinsCharacter_Flak extends TgAnimBlendByPaladinsCharacter
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var TgPawn_Flak m_CachedFlakPawn;

native function OnRetrieve();  // Export UTgAnimBlendByPaladinsCharacter_Flak::execOnRetrieve(FFrame&, void* const)

native function bool HasCachedFlakPawn();  // Export UTgAnimBlendByPaladinsCharacter_Flak::execHasCachedFlakPawn(FFrame&, void* const)

defaultproperties
{
    m_ChildParams[10]=(SlotName="Shoulder Bash Hit Retrieve")
    Children=/* Array type was not detected. */
}
