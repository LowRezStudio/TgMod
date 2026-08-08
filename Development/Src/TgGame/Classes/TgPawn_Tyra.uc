class TgPawn_Tyra extends TgPawn_Character
    native(ChampTyra)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var () WeaponDOF m_CurrentDOFSettings;

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
