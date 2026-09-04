class TgDecalManager extends DecalManager
    native(FX)
    config(Game)
    hidecategories(Navigation);

event SpawnDecalNative(bool bUsePool, MaterialInterface DecalMaterial, Vector DecalLocation, Rotator DecalOrientation, float Width, float Height, float Thickness, bool bNoClip) { }

defaultproperties
{}
