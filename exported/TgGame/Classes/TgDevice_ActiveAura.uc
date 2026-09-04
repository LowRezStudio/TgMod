class TgDevice_ActiveAura extends TgDevice_Aura
    native(Devices)
    hidecategories(Navigation);

simulated state DeviceFiring
{
    simulated function BeginState(name PrevStateName)
    {
        EnableAura();
        super.BeginState(PrevStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        DisableAura();
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}
