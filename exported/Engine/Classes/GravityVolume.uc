class GravityVolume extends PhysicsVolume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display);

var() float GravityZ;

defaultproperties
{
    GravityZ=-520.0000000
    // Reference: BrushComponent'Engine.Default__GravityVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}