class TgDevice_Midnight extends TgDevice
    native(ChampBlades)
    hidecategories(Navigation);

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn_Blades Blades;

        Blades = TgPawn_Blades(Instigator);
        // End:0x4C
        if(Blades != none)
        {
            Blades.SetGemEmissiveAnim(6);
        }
        super.StartFiringLogic();
        //return;        
    }
    stop;    
}
