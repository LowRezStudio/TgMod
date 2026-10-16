class TgPawn_Longbow extends TgPawn_Character
    native(ChampLongbow)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject, TgPawn);

var TgDevice_LongbowInhand m_CachedInhand;
var repnotify bool r_bImpalerArrowIsActive;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bImpalerArrowIsActive;
}

native function UpdateStealthScarfMaterial();  // Export UTgPawn_Longbow::execUpdateStealthScarfMaterial(FFrame&, void* const)

native function bool HasCachedInhandDevice();  // Export UTgPawn_Longbow::execHasCachedInhandDevice(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated function ToggleImpalerArrow(bool bEnabled) { }

simulated event ApplyStealthClient(optional bool bForce=false) { }

simulated event KillAllOwnedPets() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

simulated function ClearImpalerArrow() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

simulated event bool RespectsEmoteGlobalCooldown(TgPawn.EEmote Emote) { }

simulated event float GetEmoteInternalCooldown(TgPawn.EEmote Emote) { }

simulated event bool CanEmoteDuringTimelapse(TgPawn.EEmote Emote) { }

defaultproperties
{}
