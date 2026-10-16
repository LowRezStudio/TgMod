class TgPawn_MalDamba extends TgPawn_Character
    native(ChampMalDamba)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var TgDeviceFire_SnakeToss m_CachedSnakeTossDeviceFire;

simulated function string GetAnimSetString(TgObject.EMountType MountType) { }

defaultproperties
{}
