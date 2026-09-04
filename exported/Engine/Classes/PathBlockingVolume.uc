class PathBlockingVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display);

defaultproperties
{
    // Reference: BrushComponent'Engine.Default__PathBlockingVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        BlockActors=true
        BlockZeroExtent=true
        BlockRigidBody=true
        AlwaysLoadOnClient=false
        AlwaysLoadOnServer=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bWorldGeometry=true
    bCollideActors=false
    bBlockActors=true
    CollisionComponent=BrushComponent0
}