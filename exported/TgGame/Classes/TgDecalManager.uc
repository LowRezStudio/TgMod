class TgDecalManager extends DecalManager
    native(FX)
    config(Game)
    hidecategories(Navigation);

event SpawnDecalNative(bool bUsePool, MaterialInterface DecalMaterial, Vector DecalLocation, Rotator DecalOrientation, float Width, float Height, float Thickness, bool bNoClip)
{
    SpawnDecal(bUsePool, DecalMaterial, DecalLocation, DecalOrientation, Width, Height, Thickness, bNoClip);
    //return;    
}

defaultproperties
{
    // Reference: DecalComponent'TgGame.Default__TgDecalManager.BaseDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BaseDecal'
    // Archetype: DecalComponent'Engine.Default__DecalManager.BaseDecal'
    begin object name="BaseDecal"
        ReplacementPrimitive=none
    end object
    DecalTemplate=BaseDecal
    DecalBlendRange=(X=1.0000000,Y=70.0000000)
}