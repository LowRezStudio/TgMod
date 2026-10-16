class TgDevice_Vengeance_Lex extends TgDevice
    native(ChampLex)
    hidecategories(Navigation);

const DISCOVERY_DEVICE_ID = 16914;

var repnotify TgRepInfo_Player r_MarkedPlayer;
var TgPawn s_PreviouslyMarkedPlayer;
var array<TgPawn_Character> m_EnemyPawns;
var bool s_bRevealApplied;
var TgDevice s_DiscoveryDevice;

replication
{
    // Pos:0x000
    if((bNetOwner && bNetInitial || bNetDirty) && int(Role) == int(ROLE_Authority))
        r_MarkedPlayer;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_MarkedPlayer')
    {
        UpdateMarkedPlayer();
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

// Export UTgDevice_Vengeance_Lex::execMarkRandomPlayer(FFrame&, void* const)
native function MarkRandomPlayer();

// Export UTgDevice_Vengeance_Lex::execUpdateMarkedPlayer(FFrame&, void* const)
native function UpdateMarkedPlayer();

// Export UTgDevice_Vengeance_Lex::execSetMarkedPlayer(FFrame&, void* const)
native function SetMarkedPlayer(TgRepInfo_Player Target);

// Export UTgDevice_Vengeance_Lex::execCalculateBounty(FFrame&, void* const)
native function int CalculateBounty();

simulated function FireAmmunition()
{
    super.FireAmmunition();
    MarkRandomPlayer();
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    super.LinkedDeviceEquipped(Dev);
    // End:0x5F
    if((Dev != none) && Dev.r_nDeviceId == 16914)
    {
        s_DiscoveryDevice = Dev;
    }
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    super.LinkedDeviceUnequipped(Dev);
    // End:0x57
    if((Dev != none) && Dev.r_nDeviceId == 16914)
    {
        s_DiscoveryDevice = none;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=16914
}