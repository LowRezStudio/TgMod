class DecalActorMovable extends DecalActorBase
    native(Decal)
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: DecalComponent'Engine.Default__DecalActorMovable.NewDecalComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'NewDecalComponent'
    // Archetype: DecalComponent'Engine.Default__DecalActorBase.NewDecalComponent'
    begin object name="NewDecalComponent"
        bMovableDecal=true
        ReplacementPrimitive=none
    end object
    Decal=NewDecalComponent
    Components[0]=NewDecalComponent
    Components[1]=none
    Components[2]=none
    bStatic=false
    bNoDelete=true
    bHardAttach=true
    bMovable=true
}