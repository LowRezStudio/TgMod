class TgDevice_MountMorph extends TgDevice_Mount
    hidecategories(Navigation);

simulated state DeviceFiring
{
    simulated function BeginState(name PrevStateName)
    {
        local TgPawn TgP;

        super.BeginState(PrevStateName);
        TgP = TgPawn(Instigator);
        // End:0x96
        if((TgP != none) && int(Role) == int(ROLE_Authority))
        {
            TgP.r_bMorphMounted = true;
            TgP.bNetDirty = true;
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn TgP;

        super.EndState(NextStateName);
        TgP = TgPawn(Instigator);
        // End:0x96
        if((TgP != none) && int(Role) == int(ROLE_Authority))
        {
            TgP.r_bMorphMounted = false;
            TgP.bNetDirty = true;
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bPostureChange=false
}