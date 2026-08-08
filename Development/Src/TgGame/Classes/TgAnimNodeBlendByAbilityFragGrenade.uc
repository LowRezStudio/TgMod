class TgAnimNodeBlendByAbilityFragGrenade extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

function StartThrow() { }

native function OnInterrupt();  // Export UTgAnimNodeBlendByAbilityFragGrenade::execOnInterrupt(FFrame&, void* const)

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="FragGrenadeAbilityBlendNode"
}
