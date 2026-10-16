class CoverGroup extends Info
    native
    placeable
    hidecategories(Navigation,Movement,Collision)
    classgroup(Cover);

enum ECoverGroupFillAction
{
    CGFA_Overwrite,                 // 0
    CGFA_Add,                       // 1
    CGFA_Remove,                    // 2
    CGFA_Clear,                     // 3
    CGFA_Cylinder,                  // 4
    CGFA_MAX                        // 5
};

var() array<ActorReference> CoverLinkRefs;
var() float AutoSelectRadius;
var() float AutoSelectHeight;

// Export UCoverGroup::execEnableGroup(FFrame&, void* const)
native function EnableGroup();

// Export UCoverGroup::execDisableGroup(FFrame&, void* const)
native function DisableGroup();

// Export UCoverGroup::execToggleGroup(FFrame&, void* const)
native function ToggleGroup();

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x41
    if(Action.InputLinks[0].bHasImpulse)
    {
        EnableGroup();
    }
    // End:0x82
    if(Action.InputLinks[1].bHasImpulse)
    {
        DisableGroup();
    }
    // End:0xC4
    if(Action.InputLinks[2].bHasImpulse)
    {
        ToggleGroup();
    }
    //return;    
}

defaultproperties
{
    Components[0]=none
    Components[1]=none
    bStatic=true
}