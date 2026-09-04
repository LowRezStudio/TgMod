class TgAnimNodeBlendByAbilityFragGrenade extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

function StartThrow()
{
    // End:0x28
    if(ActiveChildIndex != 2)
    {
        SetActiveChild(2, GetBlendTime(2));
    }
    //return;    
}

// Export UTgAnimNodeBlendByAbilityFragGrenade::execOnInterrupt(FFrame&, void* const)
native function OnInterrupt();

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="FragGrenadeAbilityBlendNode"
}