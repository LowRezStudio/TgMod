class TgDevice_ChainLightning extends TgDevice_ArcingBeam
    hidecategories(Navigation);

var TgDevice m_CachedInhand;

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        local TgPawn TgP;

        // End:0x64
        if(m_CachedInhand == none)
        {
            TgP = TgPawn(Owner);
            // End:0x64
            if(TgP != none)
            {
                m_CachedInhand = TgP.GetDeviceByEqPoint(1);
            }
        }
        // End:0x94
        if(m_CachedInhand != none)
        {
            m_CachedInhand.SetFireMode(1, true);
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn TgP;

        // End:0x64
        if(m_CachedInhand == none)
        {
            TgP = TgPawn(Owner);
            // End:0x64
            if(TgP != none)
            {
                m_CachedInhand = TgP.GetDeviceByEqPoint(1);
            }
        }
        // End:0x94
        if(m_CachedInhand != none)
        {
            m_CachedInhand.SetFireMode(0, true);
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}
