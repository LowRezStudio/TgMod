class TgDevice_Vengeance_Lex extends TgDevice
    native(ChampLex)
    hidecategories(Navigation)
    config(Engine);

const DISCOVERY_DEVICE_ID = 16914;

var repnotify TgRepInfo_Player r_MarkedPlayer;
var TgPawn s_PreviouslyMarkedPlayer;
var array<TgPawn_Character> m_EnemyPawns;
var bool s_bRevealApplied;
var TgDevice s_DiscoveryDevice;

replication {
    if((bNetOwner && bNetInitial || bNetDirty) && int(Role) == int(ENetRole.ROLE_Authority)) r_MarkedPlayer;
}

simulated event ReplicatedEvent(name VarName) { }

native function MarkRandomPlayer();  // Export UTgDevice_Vengeance_Lex::execMarkRandomPlayer(FFrame&, void* const)

native function UpdateMarkedPlayer();  // Export UTgDevice_Vengeance_Lex::execUpdateMarkedPlayer(FFrame&, void* const)

native function SetMarkedPlayer(TgRepInfo_Player Target);  // Export UTgDevice_Vengeance_Lex::execSetMarkedPlayer(FFrame&, void* const)

native function int CalculateBounty();  // Export UTgDevice_Vengeance_Lex::execCalculateBounty(FFrame&, void* const)

simulated function FireAmmunition() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_nLinkedDeviceIDs[0]=16914
}
