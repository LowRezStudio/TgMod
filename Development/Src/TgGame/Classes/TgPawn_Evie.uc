class TgPawn_Evie extends TgPawn_Character
    native(ChampEvie)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

simulated event KillAllOwnedPets() { }

event bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation) { }

function ClearBlink() { }

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
