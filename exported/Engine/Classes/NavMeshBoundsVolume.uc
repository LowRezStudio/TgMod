class NavMeshBoundsVolume extends Volume
    placeable
    hidecategories(Navigation,Object,Movement,Display);

defaultproperties
{
    BrushColor=(R=74,G=74,B=74,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__NavMeshBoundsVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bCollideActors=false
    CollisionComponent=BrushComponent0
}