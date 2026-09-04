class TgInventoryObject_Listen_Combo extends TgInventoryObject_Listen_AbilityProcBase
    native(Inventory);

simulated event AddUIMarks(Actor Target, int nNumMarks)
{
    local TgRepInfo_Player targetPRI, sourcePRI;
    local TgPawn TargetPawn, sourcePawn;

    // End:0x134
    if(s_Device != none)
    {
        sourcePawn = TgPawn(s_Device.Owner);
        TargetPawn = TgPawn(Target);
        // End:0x134
        if((sourcePawn != none) && TargetPawn != none)
        {
            sourcePRI = sourcePawn.GetPRI();
            targetPRI = TargetPawn.GetPRI();
            // End:0x134
            if((sourcePRI != none) && targetPRI != none)
            {
                targetPRI.AddMarkedTarget(sourcePRI.r_nPawnId, nNumMarks);
            }
        }
    }
    //return;    
}

simulated event RemoveUIMarks(Actor Target, int nNumMarks)
{
    local TgRepInfo_Player targetPRI, sourcePRI;
    local TgPawn TargetPawn, sourcePawn;

    // End:0x134
    if(s_Device != none)
    {
        sourcePawn = TgPawn(s_Device.Owner);
        TargetPawn = TgPawn(Target);
        // End:0x134
        if((sourcePawn != none) && TargetPawn != none)
        {
            sourcePRI = sourcePawn.GetPRI();
            targetPRI = TargetPawn.GetPRI();
            // End:0x134
            if((sourcePRI != none) && targetPRI != none)
            {
                targetPRI.RemoveMarkedTarget(sourcePRI.r_nPawnId, nNumMarks);
            }
        }
    }
    //return;    
}
